// src/prerender-params.ts
export default async function getPrerenderParams() {
  const routes = [];

  // Routes statiques
  routes.push('/');
  routes.push('/login');
  routes.push('/register');
  routes.push('/cars');

  // Routes paramétrées - exemples d'immatriculations
  const immatriculations = ['AA-123-BB', 'CC-456-DD', 'EE-789-FF'];

  for (const immat of immatriculations) {
    routes.push(`/update/${immat}`);
  }

  return routes;
}
