From: "Dr. Ing. Dieter Jurzitza" <dieter.jurzitza@t-online.de>
Date: Fri, 09 Jul 2010 23:03:55 +0000
Subject: kernel mode setting / how to configure the console's resolution X x Y with KMS active
Message-Id: <201007100103.55941.dieter.jurzitza@t-online.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Dear listmembers,
I am not sure whether or not I am at the right place here, but I'll give it=
 a=20
try as the list's name sounded most close to what I would like to talk abou=
t.

Recently I installed a brand new linux distro coming with the KMS-feature. =

Though appearing quite satisfying at the first glance I noted several=20
drawbacks you probably can give answers to / set me on the right track.

The console mode is radically set to the maximum that is promoted by the=20
monitor's edid. This leaves the console on my system totally useless as 204=
8 x=20
something points on a 21'' display - well, if I was thirty years younger ..=
.=20
and my eyes were still that good ....

Configuration options? Nope. Turn it off, if it disturbs you, I was told.

This is not the way things ought to be. I would like to use KMS for X11 - b=
ut=20
in X11, there is xrandr, so I have a chance to configure things afterwards =
-=20
but the console - like it or leave it? The distros drop the xorg.conf creat=
ion=20
software, saying that there is KMS - but the console is left alone(?)

I have been searching for documentation, but in vain so far. Is there any=20
friendly guy around explaining to me how to tame that beast? Is it really=20
intended (think of visually impaired people ....) that there is no way to=20
configure this behaviour?

By the way, I am using kernel 2.6.34<something>

Playing around with fbset yielded nothing but cryptic messages about not=20
existing modes though being present in /etc/fb.modes.

Thank you very much for your help in advance,
take care




Dieter Jurzitza


--=20
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <=B0=B0__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

