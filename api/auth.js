export default () => ({
  async restore({ token }) {
    console.log({ method: "auth.restore", token });
    return { status: "ok" };
  },

  async signIn({ login, password }) {
    console.log({ method: "auth.signin", login, password });
    return { status: "ok", token: "--no-token-provided--" };
  },

  async signOut() {
    console.log({ method: "auth.signout" });
    return { status: "ok" };
  },
});
