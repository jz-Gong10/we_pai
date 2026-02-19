import 'package:flutter/material.dart';

void navigate(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}

//客单广场
class Kedanguangchang extends StatefulWidget {
  const Kedanguangchang({super.key});

  @override
  State<Kedanguangchang> createState() => _KedanguangchangState();
}

class _KedanguangchangState extends State<Kedanguangchang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      height: 210,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // navigate(context, );
        },
        child: Container(
          width: 172,
          height: 210,
          alignment: Alignment.center,
          child: Image.asset('lib/material/kedanguangchang.png'),
        ),
      ),
    );
  }
}

//摄影师列表
class Sheyingshiliebiao extends StatefulWidget {
  const Sheyingshiliebiao({super.key});

  @override
  State<Sheyingshiliebiao> createState() => _SheyingshiliebiaoState();
}

class _SheyingshiliebiaoState extends State<Sheyingshiliebiao> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 174,
      height: 147,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // navigate(context, );
        },
        child: Container(
          width: 174,
          height: 147,
          alignment: Alignment.center,
          child: Image.asset('lib/material/sheyingshiliebiao.png'),
        ),
      ),
    );
  }
}

//作品展示
class Zuopinzhanshi extends StatefulWidget {
  const Zuopinzhanshi({super.key});

  @override
  State<Zuopinzhanshi> createState() => _ZuopinzhanshiState();
}

class _ZuopinzhanshiState extends State<Zuopinzhanshi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 172,
      height: 210,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // navigate(context, );
        },
        child: Container(
          width: 172,
          height: 208,
          alignment: Alignment.center,
          child: Image.asset('lib/material/zuopinzhanshi.png'),
        ),
      ),
    );
  }
}

//摄影实践圈
class Sheyingshijianquan extends StatefulWidget {
  const Sheyingshijianquan({super.key});

  @override
  State<Sheyingshijianquan> createState() => _SheyingshijianquanState();
}

class _SheyingshijianquanState extends State<Sheyingshijianquan> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 137,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // navigate(context, );
        },
        child: Container(
          width: 168,
          height: 137,
          alignment: Alignment.center,
          child: Image.asset('lib/material/sheyingshijianquan.png'),
        ),
      ),
    );
  }
}

//排行榜
class Paihangbang extends StatefulWidget {
  const Paihangbang({super.key});

  @override
  State<Paihangbang> createState() => _PaihangbangState();
}

class _PaihangbangState extends State<Paihangbang> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168,
      height: 137,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          // navigate(context, );
        },
        child: Container(
          width: 168,
          height: 137,
          alignment: Alignment.center,
          child: Image.asset('lib/material/paihangbang.png'),
        ),
      ),
    );
  }
}
