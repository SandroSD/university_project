#include "tercetos.h"

int x;
int tamLista = 0;

int CrearTerceto(int p1, int p2, int p3, lista_tercetos_t *p)
{
    terceto_t terc;
    terc.operacion = p1;
    terc.opIzq = p2;
    terc.opDer = p3;
    return InsertarEnLT(p, &terc) - 1;
}

int InsertarEnLT(lista_tercetos_t *p, terceto_t *d)
{
    //Esto inserta al terceto en la lista y devuelve su posici�n.
    //La posicion puede ser tomada como el n�mero del mismo.
    t_node *nue;
    nue = (t_node *)malloc(sizeof(t_node));
    if (!nue)
        return 0;
    nue->info = *d;
    if (DEBUG)
        printf("-----------Insertar En Lista de Tercetos %d %d %d \n", nue->info.operacion, nue->info.opIzq, nue->info.opDer);
    nue->sig = NULL;
    nue->ant = *p;
    if (*p)
        (*p)->sig = nue;
    *p = nue;

    tamLista++;
    return tamLista;
}

void EliminarUltimoTerceto(lista_tercetos_t *p)
{
    if (*p != NULL)
    {
        t_node *aux = *p;
        *p = aux->ant;
        if (*p != NULL)
        {
            (*p)->sig = NULL;
        }
        free(aux);
        tamLista--;
    }
}

void VaciarLT(lista_tercetos_t *p)
{
    t_node *pri = *p, *act = *p, *aux;
    if (*p)
        pri = (*p)->ant;
    while (act)
    {
        if (act->sig)
            act->sig->ant = act->ant;
        if (act->ant)
        {
            act->ant->sig = act->sig;
            *p = act->ant;
        }
        else
            *p = act->sig;
        //printf("NARIPETA %d %d %d ",act->info.operacion,act->info.opIzq,act->info.opDer);
        aux = act;
        act = act->sig;

        free(aux);
    }
    act = pri;
    while (act)
    {
        if (act->sig)
            act->sig->ant = act->ant;
        if (act->ant)
        {
            act->ant->sig = act->sig;
            *p = act->ant;
        }
        else
            *p = act->sig;
        aux = act;
        act = act->ant;
        free(aux);
    }

    tamLista = 0;
}

void ObtenerItemLT(lista_tercetos_t *p, int pos, terceto_t *nodo)
{
    t_node *act = *p;
    int cont = 0;

    if (pos < 0)
        nodo = NULL;

    if (act)
    {
        while (act->ant)
            act = act->ant;
        while (act)
        {
            if (cont == pos)
            {
                *nodo = act->info;
                return;
            }
            else
            {
                cont++;
                act = act->sig;
            }
        }
    }

    nodo = NULL;
}

void ModificarTerceto(int op, int li, int ld, lista_tercetos_t *p, int pos)
{
    t_node *act = *p;
    int cont = 0;

    if (act)
    {
        while (act->ant)
            act = act->ant;
        while (act)
        {
            if (cont == pos)
            {
                if (op != NO_MODIF && op != NEGAR)
                {
                    act->info.operacion = op;
                }
                if (op == NEGAR)
                {
                    act->info.operacion = NegarOperador(act->info.operacion);
                }
                if (li != NO_MODIF)
                {
                    act->info.opIzq = li;
                }
                if (ld != NO_MODIF)
                {
                    act->info.opDer = ld;
                }
                return;
            }
            else
            {
                cont++;
                act = act->sig;
            }
        }
    }
}

void NegarOperadorTerceto(int pos, lista_tercetos_t *lt)
{
    terceto_t tercetoAux;

    ObtenerItemLT(lt, pos, &tercetoAux);
    ModificarTerceto(NegarOperador(tercetoAux.operacion), NO_MODIF, NO_MODIF, lt, pos);
}

int NegarOperador(int op)
{
    int op_negado;

    switch (op)
    {
    case TERC_MENOR:
        op_negado = TERC_JAE;
        break;
    case TERC_MENOR_IGUAL:
        op_negado = TERC_JA;
        break;
    case TERC_IGUAL:
        op_negado = TERC_JNE;
        break;
    case TERC_DISTINTO:
        op_negado = TERC_JE;
        break;
    case TERC_MAYOR_IGUAL:
        op_negado = TERC_JB;
        break;
    case TERC_MAYOR:
        op_negado = TERC_JBE;
        break;

    case TERC_JB:
        op_negado = TERC_JAE;
        break;
    case TERC_JBE:
        op_negado = TERC_JA;
        break;
    case TERC_JE:
        op_negado = TERC_JNE;
        break;
    case TERC_JNE:
        op_negado = TERC_JE;
        break;
    case TERC_JAE:
        op_negado = TERC_JB;
        break;
    case TERC_JA:
        op_negado = TERC_JBE;
        break;
    }

    return op_negado;
}