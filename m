From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sun, 23 Aug 2015 00:11:11 +0000
Subject: [PATCH 00/11] fix error return code
Message-Id: <1440288682-12732-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-samsung-soc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

The complate semantic patch that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@ok exists@
identifier f,ret,i;
expression e;
constant c;
@@

// identify a function that returns a negative return value at least once.
f(...) {
... when any
(
return -c@i;
|
ret =3D -c@i;
... when !=3D ret =3D e
return ret;
|
if (ret < 0) { ... return ret; }
)
... when any
}

@r exists@
identifier ret,ok.f,fn;
expression e1,e2,e3,e4,e5,e6,x;
statement S,S1;
position p1,p2,p3;
@@

// identify a case where the return variable is set to a non-negative value
// and then returned in error-handling code
f(...) {
... when any
(
if@p1 (\(ret < 0\|ret !=3D 0\))
 { ... return ret; }
|
ret@p1 =3D 0
)
... when !=3D \(ret =3D e1\|ret++\|ret--\|ret+=E1\|ret-=E1\)
    when !=3D &ret
    when any
(
 if (<+... ret =3D e5 ...+>) S1
|
 if (<+... &ret ...+>) S1
|
if@p2(<+...x =3D fn(...)...+>)
 {
  ... when !=3D ret =3D e6
      when forall
 return@p3 ret;
}
|
break;
|
x =3D fn(...)
... when !=3D \(ret =3D e4\|ret++\|ret--\|ret+=E4\|ret-=E4\)
    when !=3D &ret
(
 if (<+... ret =3D e3 ...+>) S
|
 if (<+... &ret ...+>) S
|
if@p2(<+...\(x !=3D 0\|x < 0\|x =3D NULL\|IS_ERR(x)\)...+>)
 {
  ... when !=3D ret =3D e2
      when forall
 return@p3 ret;
}
)
)
... when any
}

@printer depends on r@
position p;
identifier ok.f,pr;
constant char [] c;
@@

f(...) { <...pr@p(...,c,...)...> }

@bad0 exists@
identifier r.ret,ok.f,g !=3D {ERR_PTR,IS_ERR};
position p !=3D printer.p;
@@

f(...) { ... when any
g@p(...,ret,...)
... when any
 }

@bad depends on !bad0 exists@
position r.p1,r.p2;
statement S1,S2;
identifier r.ret;
expression e1;
@@

// ignore the above if there is some path where the variable is set to
// something else
(
if@p1 (\(ret < 0\|ret !=3D 0\)) S1
|
ret@p1 =3D 0
)
... when any
 \(ret =3D e1\|ret++\|ret--\|ret+=E1\|ret-=E1\|&ret\)
... when any
if@p2(...) S2

@bad1 depends on !bad0 && !bad exists@
position r.p2;
statement S2;
identifier r.ret;
expression e1;
constant c;
@@

ret =3D -c
... when !=3D \(ret =3D e1\|ret++\|ret--\|ret+=E1\|ret-=E1\)
    when !=3D &ret
    when any
if@p2(...) S2

@bad2 depends on !bad0 && !bad && !bad1 exists@
position r.p1,r.p2;
identifier r.ret;
expression e1;
statement S2;
constant c;
@@

// likewise ignore it if there has been an intervening return
ret@p1 =3D 0
... when !=3D if (...) { ... ret =3D e1 ... return ret; }
    when !=3D if (...) { ... return -c; }
    when any
if@p2(...) S2

@script:python depends on !bad0 && !bad && !bad1 && !bad2@
p1 << r.p1;
p2 << r.p2;
p3 << r.p3;
@@

cocci.print_main("",p1)
cocci.print_secs("",p2)
cocci.print_secs("",p3)
// </smpl>

