import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../ModelP/FirebaseServiceClient.dart';
import '../ModelP/FirebaseServiceEngagement.dart';
import '../ModelP/Projets.dart';
import '../ModelP/UsersP.dart';
import '../ModelP/clients.dart';
import '../style/colors.dart';
import 'Dialog/dialogAjouterClients.dart';

class ClientView extends StatefulWidget {
  final UserP user;
  final Projet projet;
  final FirebaseServiceEngagement firebaseServiceEngagement;
  final FirebaseServiceClient firebaseServiceClient;

  const ClientView({
    Key? key,
    required this.firebaseServiceClient,
    required this.user,
    required this.firebaseServiceEngagement,
    required this.projet,
  }) : super(key: key);

  @override
  State<ClientView> createState() => _ClientsState();
}

class _ClientsState extends State<ClientView> {
  List<Client> _allclient = [];
  List<Client> _clients = [];
  List<Client> clients = [];
  bool _visible = false;
  List<String> checkedIndex = [];
  late Projet projet;
  late UserP _user;
  String indexG="";
  TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadClients();
    _user = widget.user;
    projet = widget.projet;
  }

  Future<void> _loadClients() async {
    List<Client> cl = await widget.firebaseServiceClient.getClientsForProject(widget.user.idProjet);
    setState(() {
      _clients = cl;
      _allclient = List.from(cl);
    });
  }

  void _searchclient(String query) {
    if (query.isNotEmpty) {
      List<Client> searchedClients = _allclient.where((client) {
        String NomComplet = client.prenom.toLowerCase() + " " + client.nom.toLowerCase();
        String NomComplet2 = client.nom.toLowerCase() + " " + client.prenom.toLowerCase();
        return client.nom.toLowerCase().contains(query.toLowerCase()) ||
            NomComplet.contains(query.toLowerCase()) ||
            NomComplet2.contains(query.toLowerCase()) ||
            client.prenom.toLowerCase().contains(query.toLowerCase()) ||
            client.email.toLowerCase().contains(query.toLowerCase()) ||
            client.numeroTelephone.contains(query);
      }).toList();
      setState(() {
        _clients = searchedClients;
      });
    } else {
      setState(() {
        _clients = _allclient;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
      Row(
      children: [
      Expanded(
      child: Align(
          alignment: AlignmentDirectional(0, -1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Container(
          width: double.infinity,
          child: TextFormField(
            controller: _searchController,
            onChanged: _searchclient,
            obscureText: false,
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: AppColors.bleu,
              ),
              labelText: 'Recherche',
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.bleu,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.bleu,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.all(12),
              prefixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    _searchController.clear();
                    _searchclient('');
                  });
                },
                icon: const Icon(Icons.close, color: AppColors.rouge),
              )
                  : null,
              suffixIcon: const Icon(Icons.search, color: AppColors.bleu),
            ),
          ),
        ),
      ),
    ),
    ),
    Align(
    alignment: AlignmentDirectional(1, -1),
    child: Padding(
    padding: const EdgeInsets.fromLTRB(0, 4, 5, 4),
    child: ElevatedButton.icon(
    label: Text("Ajouter"),
    onPressed: () {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return ajouteClients(
    firebaseService: widget.firebaseServiceClient,
    user: _user,
    );
    },
    ).then((_) {
    _loadClients();
    });
    },
    icon: Icon(Icons.person_add_alt_1),
    style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.vert,
    foregroundColor: AppColors.blanc,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
    ),
    ),
    ),
    ),
    ),
    ],
    ),
    Title(
    color: AppColors.bleu,
    child: const Text(
    "Liste Clients : ",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    ),
    ),
    const Divider(
    height: 20,
    thickness: 1,
    indent: 10,
    endIndent: 10,
    ),
    _clients.isEmpty
    ? Center(
    child: _searchController.text.isNotEmpty
    ? Text(
    "Il n'y a aucun client avec ces données",
    style: TextStyle(fontSize: 18),
    )
        : Text(
    "Il n'y a aucun client pour ce projet",
    style: TextStyle(fontSize: 18),
    ),
    ) // Show loading indicator while fetching data
        : SizedBox(height: 10),
    Expanded(
    child: ListView.builder(
    itemCount: _clients.length,
      itemBuilder: (context, index) {
        final client = _clients[index];
        bool isChecked = checkedIndex.contains(client.id);
        return Card(
          elevation: 2.0,
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          color: isChecked ? Colors.green[50] : null, // Définir l'arrière-plan en vert si la case est cochée
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isChecked ? AppColors.vert : Colors.transparent, // Définir la bordure en vert si la case est cochée
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            title: Text(
              "${client.nom} ${client.prenom}",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: isChecked ? AppColors.vert : null,
              ),
            ),
            subtitle: Text(
              '${client.email}\n${client.numeroTelephone}',
              style: TextStyle(
                fontSize: 14.0,
                color: isChecked ? AppColors.vert : null,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    indexG = client.id;
                    _showDeleteDialog(context);
                  },
                  icon: const Icon(Icons.delete, size: 30),
                  color: AppColors.rouge,
                ),
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        clients.add(client);
                        checkedIndex.add(client.id);
                      } else {
                        clients.remove(client);
                        checkedIndex.remove(client.id);
                      }
                    });
                  },
                  activeColor: AppColors.vert, // Couleur de la case cochée
                  checkColor: Colors.white, // Couleur de la coche
                ),
              ],
            ),
          ),
        );
      },
    ),
    ),
            Divider(
              height: 10,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            Align(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton.icon(
                  label: Text("Envoyer"),
                  onPressed: () {
                    _showDialog(context);
                  },
                  icon: Icon(Icons.send),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.vert,
                    foregroundColor: AppColors.blanc,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }

  void envoyer(String password, BuildContext dialogContext) async {
    if (clients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: const EdgeInsets.all(15),
            height: 100,
            decoration: const BoxDecoration(
              color: AppColors.rouge,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Error !",
                      style: TextStyle(fontSize: 20, color: AppColors.blanc),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.delete_forever, color: AppColors.blanc),
                  ],
                ),
                Text(
                  "Vous n'avez choisi aucun client !",
                  style: TextStyle(fontSize: 15, color: AppColors.blanc),
                ),
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
    } else {
      String username = projet.email;

      try {
        for (Client c in clients) {
          final smtpServer = gmail(username, password);
          final message = Message()
            ..from = Address(username, "${projet.nomProjet}")
            ..recipients.add(c.email)
            ..subject = 'Invitation à évaluer notre projet sur Google Avis'
            ..text =
                'Bonjour,\n\nNous espérons que vous allez bien. Nous sommes ravis de vous inviter à donner votre avis sur notre projet récent. Votre opinion est très importante pour nous et nous aide à améliorer constamment nos services.\n\nVous pouvez évaluer notre projet et laisser votre avis en suivant ce lien : ${projet.projetUrl}\n\nNous vous remercions par avance pour votre temps et votre retour.\n\nCordialement,\n${projet.nomProjet}';
          await send(message, smtpServer);
        }
        clients.clear();
        checkedIndex.clear();
        _loadClients();
        clients.clear();
        checkedIndex.clear();
        _loadClients();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.all(15),
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.vert,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Succès !",
                        style: TextStyle(fontSize: 20, color: AppColors.blanc),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.done, color: AppColors.blanc),
                    ],
                  ),
                  Text(
                    "Le message a été envoyé aux clients sélectionnés.",
                    style: TextStyle(fontSize: 15, color: AppColors.blanc),
                  ),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      } on MailerException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.all(15),
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.rouge,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Error !",
                        style: TextStyle(fontSize: 20, color: AppColors.blanc),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.delete_forever, color: AppColors.blanc),
                    ],
                  ),
                  Text(
                    "Le message n'a pas été envoyé",
                    style: TextStyle(fontSize: 15, color: AppColors.blanc),
                  ),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        clients.clear();
        checkedIndex.clear();
        _loadClients();
      }
    }

    // Close the dialog
    Navigator.of(dialogContext).pop();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: AppColors.blanc,
                title: const Text(
                  'Envoyer :',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Pour envoyer ce message, vous devez créer un mot de passe d\'application. Si vous en avez déjà un, saisissez-le. Sinon, créez-le à partir de ce lien : https://myaccount.google.com/apppasswords',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_visible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Le mot de passe ne doit pas être vide";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: AppColors.bleu,
                          ),
                          labelText: 'Mot de passe',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.bleu,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.bleu,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: AppColors.rouge,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.all(12),
                          prefixIcon: const Icon(Icons.lock, color: AppColors.bleu),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _visible ? Icons.visibility_off : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _visible = !_visible;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Annuler'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.vert,
                      foregroundColor: AppColors.blanc,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String password = _passwordController.text;
                        envoyer(password, context);
                      }
                    },
                    child: const Text('Envoyer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.rouge,
                      foregroundColor: AppColors.blanc,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }



  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.bleu,
          title: const Text(
            'Confirmation :',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.blanc),
          ),
          content: const Text(
            'Voulez-vous vraiment supprimer ce client ?',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.blanc),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.vert,
                foregroundColor: AppColors.blanc,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.firebaseServiceClient.supprimerClient(indexG);
                widget.firebaseServiceEngagement.supprimerEngagement(indexG);
                Navigator.of(context).pop();
                _loadClients();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Container(
                      padding: const EdgeInsets.all(15),
                      height: 100,
                      decoration: const BoxDecoration(
                        color: AppColors.rouge,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Succès !",
                                style: TextStyle(fontSize: 20, color: AppColors.blanc),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.delete_forever, color: AppColors.blanc),
                            ],
                          ),
                          Text(
                            "Le client a été supprimé",
                            style: TextStyle(fontSize: 15, color: AppColors.blanc),
                          ),
                        ],
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                );
              },
              child: const Text('Supprimer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.rouge,
                foregroundColor: AppColors.blanc,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}


