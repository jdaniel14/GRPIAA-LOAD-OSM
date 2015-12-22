#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <sstream>
#include <cstdio>
#include <set>
using namespace std;

vector < vector <int> > g;
vector < int > h;
vector <int> visited;
map <int, int> mp;
map <int, int> mp_verdad;
set <int> s_arista;

map < pair<int, int>, int > mp_arista;

int var;
string cad_update;

string to_string(int number)
{
   stringstream ss;//create a stringstream
   ss << number;//add number to the stream
   return ss.str();//return a string with the contents of the stream
}

string update_db(int id, vector<int> h){

	string data			= "";

	//cout << h.size() << endl;
	for(int i = 0; i < h.size(); i++) {
		//cout << h[i] << endl;
		if (data != "")
			data	= data + ",";
		data	= data + " (" + to_string(h[i]) + ") ";
	}

	//cout << "fin" << endl;
	string cad_final	= "UPDATE nodo SET grafo = " + to_string(id) + " WHERE idnodo = ANY (VALUES " + data + ");";
	
	//cout << cad_final << endl;
	return cad_final;
}

string update_db_set(int id, set<int> s){

	string data	= "";
	int val;
	//cout << h.size() << endl;
	for(set <int> :: iterator it = s.begin(); it != s.end(); it++) {
		val	= *it;
		if (data != "")
			data	= data + ",";
		data	= data + " (" + to_string(val) + ") ";

	}

	//cout << "fin" << endl;	
	string cad_final	= "UPDATE arista SET grafo = " + to_string(id) + " WHERE idarista = ANY (VALUES " + data + ");";
	//cout << cad_final << endl;
	return cad_final;
}

int lectura_nodos() {
	int pos	= 0;
	int x;
	int cant;
	cin >> cant;
	while(cant--){
		cin >> x;
		mp[x]	= pos;
		mp_verdad[pos]	= x;
		pos++;
	}
	return pos;
}

void lectura_arista() {
	int ind, x, y;
	int cant;
	cin >> cant;
	while(cant--){
		cin >> ind >> x >> y;
		//cout << ind << " " << x << " " <<  y << endl;
		//break;
		mp_arista[make_pair(x, y)] = ind;
		mp_arista[make_pair(y, x)] = ind;

		g[mp[x]].push_back(mp[y]);
		g[mp[y]].push_back(mp[x]);
	}
}

int graph_dfs(int ini) {
	h.push_back(mp_verdad[ini]);
	var++;
	visited[ini] 	= 1;
	for(int i = 0 ; i < g[ini].size(); i++)	{
		int hijo	= g[ini][i];
		//printf("arista (%d, %d) -> ind: %d\n", mp_verdad[ini], mp_verdad[hijo], mp_arista[make_pair(ini, hijo)]);
		int x	= mp_verdad[ini];
		int y	= mp_verdad[hijo];
		int ind_arista1 = mp_arista[make_pair(x, y)];
		//int ind_arista2 = mp_arista[make_pair(y, x)];

		s_arista.insert(ind_arista1);
		//s_arista.insert(ind_arista2);

		if (!visited[hijo]) {
			graph_dfs(hijo);
			
		}
	}
}


int main(){
	mp			= map <int, int>();
	mp_verdad	= map <int, int>();

	int size	= lectura_nodos();
	g 		= vector < vector <int> > (size);
	visited	= vector <int> (size + 5, 0);
	lectura_arista();

	int cont	= 0, i;
	cout << "antes del dfs" << endl;
	//i = mp[92185];
	
	
	for(i = 0; i < size; i++){
		if (!visited[i]){
			var = 0;
			h = vector <int>();
			s_arista = set <int>();
			graph_dfs(i);
			//cout << "antes de update" << endl;
			string cad	= update_db_set(cont, s_arista);
			
			//cout << "despues" << endl;
			cout << cad << endl;
			//cout << var << endl;
			//cout << endl << endl;
			cont++;
			//break;
		}
	}
	//cout << "numero de grafos " << cont << endl;

	return 0;
}
