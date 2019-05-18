#include "ts.h"

int puntero_ts = 0;
int posicion_en_ts = 0; // Incremento Longitud en la estructura tabla de simbolos
int cont_cte_str=1; // nose lo que hace

int crearArchivoTS2()
{
	FILE *archivo; 
	int i;
	archivo = fopen("ts2.txt","wt"); 
	if (!archivo){	return ERROR; }
	
	//fprintf(archivo, "Nombre^Tipo^Longitud^Valorn");
	for (i = 0; i < puntero_ts; i++)
	{
		if (strcmp(tablaSimbolos[i].tipo, "INTEGER") == 0 || strcmp(tablaSimbolos[i].tipo, "REAL") == 0  || strcmp(tablaSimbolos[i].tipo, "STRING") == 0 )
		{  
			fprintf(archivo,"%s\n%s\n-\n-\n*****\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo);
		}
		else if(strcmp(tablaSimbolos[i].tipo, "CONST_STR") == 0 )
		{
			fprintf(archivo,"%s\n%s\n%s\n%s\n*****\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo,tablaSimbolos[i].longitud,tablaSimbolos[i].valor);
		}
		else if(strcmp(tablaSimbolos[i].tipo, "CONST_INT") == 0 || strcmp(tablaSimbolos[i].tipo, "CONST_REAL") == 0)
		{
			fprintf(archivo,"_%s\n%s\n-\n%s\n*****\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo,tablaSimbolos[i].valor);
		}
		else 
		{
			fprintf(archivo,"%s\n%s\n-\n%s\n*****\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo,tablaSimbolos[i].valor);
		}
	}
	
	
	fclose(archivo); 
	return TODO_OK;
}

int insertar_TS(char* tipo, char* nombre)
{
	int i, posicion;
	
	for(i = 0; i < puntero_ts; i++)
	{
		if(strcmp(tablaSimbolos[i].nombre, nombre) == 0)
		{
			return i;
		}
	}
	
		
	if(strcmp(tipo,"CONST_STR") == 0)
	{
		sprintf(tablaSimbolos[puntero_ts].nombre, "cteStr%d", cont_cte_str);
		cont_cte_str++;
		
	}else{
		strcpy(tablaSimbolos[puntero_ts].nombre, nombre);
	}
	
	strcpy(tablaSimbolos[puntero_ts].tipo, tipo);
	
	if(strcmp(tipo,"CONST_STR") == 0)
	{
		int longitud = strlen(nombre);
		sprintf(tablaSimbolos[puntero_ts].longitud, "%d", longitud);	
		//printf("\tVALOR NOMBRE TS: %s\n",nombre);
		sprintf(tablaSimbolos[puntero_ts].valor, "%s",nombre);
	} 
	else if (strcmp(tipo,"CONST_INT") == 0  || strcmp(tipo,"CONST_REAL") == 0 )
	{
		strcpy(tablaSimbolos[puntero_ts].valor, tablaSimbolos[i].nombre);
	}
	
	posicion = puntero_ts;
	puntero_ts++;
	return posicion;
}

char * recuperarTipoTS(char* nombre)
{
	//printf("Recuperando: %s\n",nombre);
	int i;
	for (i=0;i < puntero_ts;i++)
	{
		//printf("Voy a comprar %s con %s \n",nombre, tablaSimbolos[i].nombre);
		if(strcmp(nombre,tablaSimbolos[i].nombre) == 0)
		{
			return tablaSimbolos[i].tipo;
		}
	}
	return ERROR;
}

int crearArchivoTS()
{
	FILE *archivo; 
	int i;
	archivo = fopen("ts.txt","wt"); 
	if (!archivo){	return ERROR; }
	
	fprintf(archivo, "Nombre^Tipo^Longitud^Valorn");
	for (i = 0; i < puntero_ts; i++)
	{
		if (strcmp(tablaSimbolos[i].tipo, "INTEGER") == 0 || strcmp(tablaSimbolos[i].tipo, "REAL") == 0  || strcmp(tablaSimbolos[i].tipo, "STRING") == 0 )
		{  
			fprintf(archivo,"%s^%s^-^-\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo);
		}
		else if(strcmp(tablaSimbolos[i].tipo, "CONST_STR") == 0 )
		{
			fprintf(archivo,"%s^%s^%s^%s\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo,tablaSimbolos[i].longitud,tablaSimbolos[i].valor);
		}
		else if(strcmp(tablaSimbolos[i].tipo, "CONST_INT") == 0 || strcmp(tablaSimbolos[i].tipo, "CONST_REAL") == 0)
		{
			fprintf(archivo,"_%s^%s^-^%s\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo,tablaSimbolos[i].valor);
		}
		else 
		{
			fprintf(archivo,"%s^%s^-^%s\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo,tablaSimbolos[i].valor);
		}
	}
	
	
	fclose(archivo); 
	return TODO_OK;
}

void debugTS()
{
	int i;
	printf("====== DEBUG TABLA SIMBOLOS ======\n\n");
	printf("La cantidad de elementos es %d \n",puntero_ts);		
	printf("Lista de elementos: \n");		
	for (i=0; i < puntero_ts;i++){
		printf("%d => %s | %s | %s | %s \n",i,tablaSimbolos[i].nombre,tablaSimbolos[i].tipo,tablaSimbolos[i].valor,tablaSimbolos[i].longitud );		
	}
	
	printf("\n====== FIN DEBUG TABLA SIMBOLOS ======\n\n");	
	
}


char * recuperarValorTS(char* nombre)
{
	int i;
	for (i=0;i < puntero_ts;i++)
	{
		//printf("Voy a comprar %s con %s \n",nombre, tablaSimbolos[i].nombre);
		if(strcmp(nombre,tablaSimbolos[i].nombre) == 0)
		{
			return tablaSimbolos[i].valor;
		}
	}
	return ERROR;
}

int crear_TS()
{
	FILE *archivo; 
	int i;
	archivo = fopen("ts.txt","w"); 

	if (!archivo){	return ERROR; }

	// fprintf(archivo, "Nombre\t\t\tTipo\t\t\tValor\t\t\tLongitud\n");
	// Cabecera del archivo
	fprintf(archivo, "%-30s%-12s%-30s%-12s\n","Nombre","Tipo","Valor","Longitud");
	
	for (i = 0; i < posicion_en_ts; i++)
	{
		if (strcmp(tablaSimbolos[i].tipo, "INTEGER") == 0 || strcmp(tablaSimbolos[i].tipo, "REAL")
		|| strcmp(tablaSimbolos[i].tipo, "STRING"))
		{  
			fprintf(archivo,"%-30s%-12s\n", tablaSimbolos[i].nombre, tablaSimbolos[i].tipo);
		}
		else
		{
			int longitud = strlen(tablaSimbolos[i].nombre);
			fprintf(archivo,"_%-29s%-12s%-30s%-12d\n", 
			tablaSimbolos[i].nombre, tablaSimbolos[i].tipo, tablaSimbolos[i].nombre, longitud);
		}
	}
	fclose(archivo); 

	return TODO_OK;
}

int push_TS(char* tipo, char* nombre)
{
	int i, posicion;
	
	for(i = 0; i < posicion_en_ts; i++)
	{
		if(strcmp(tablaSimbolos[i].nombre, nombre) == 0)
		{
			return i;
		}
	}
	strcpy(tablaSimbolos[posicion_en_ts].tipo, tipo);
	strcpy(tablaSimbolos[posicion_en_ts].nombre, nombre);
	posicion = posicion_en_ts;
	posicion_en_ts++;
	return posicion;
}