From: Daniele Salvatore Albano <info@daccii.it>
Date: Wed, 01 Jun 2011 20:37:42 +0000
Subject: Re: Mirror "module" for framebuffer
Message-Id: <4DE6A316.1000101@daccii.it>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4DE67493.6090708@daccii.it>
In-Reply-To: <4DE67493.6090708@daccii.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Il 01/06/2011 22:02, Bruno Pr=E9mont ha scritto:
> Hi,
>
> [re-adding linux-fbdev, please make sure to reply-to-all]

uops

 > Note that some framebuffer drivers might implement (lots) of private
 > ioctls to implement (accelerated) drawing primitives.
 > So unless you know the driver you are hooking onto all bets are open.
.
.
.
> No, only a few selected ones implement deferred input/output, usually
> because the real framebuffer cannot be mapped into memory or the link
> to it is just dead slow so changes are pushed down to device at regular
> intervals.
.
.
.
> I'm wondering if you not better had to create a new framebuffer driver
> (based on virtual framebuffer) with fbdefio to push the changes to a
> backing framebuffer [the way fbcon draws console] (as well as whatever you
> use to stream to the remote system).
> This will make you lose any potential hardware acceleration but keep
> things simple.
> Though you would need ability to move software to your new framebuffer.

Main problem is that i need to show what is being displayed on the=20
screen, so i can't use another framebuffer device but i must use the one=20
used by the os.

mmm i think that isin't the right way to handle this situation because=20
this software should work with too much different (and untestable) hardware.
I'll see if there is a way to check when android draw something on the=20
framebuffer

Thanks a lot for your time!


Best Regards,
Daniele
--=20
____________________________________________________________
                                         |
Daniele Salvatore Albano                | web site:
  IT Consultant                          | http://www.itechcon.it
  Website Design and Development         |
  Software Engineer and Developer        | e-mail:
  Linux Servers SetUp And Administration | info@itechcon.it
  Embedded Network Solutions             | d.albano@itechcon.it

Are you lazy? Take a look to LazyDroid (www.lazydroid.net): android for=20
lazy people!

Ai sensi del D.Lgs. 196/2003 si precisa che le informazioni contenute in=20
questo messaggio sono riservate ed a uso esclusivo del destinatario.=20
Qualora il messaggio in parola Le fosse pervenuto per errore, La=20
invitiamo ad eliminarlo senza copiarlo e a non inoltrarlo a terzi,=20
dandocene gentilmente comunicazione. Grazie.
Pursuant to Legislative Decree No. 196/2003, you are hereby informed=20
that this message contains confidential information intended only for=20
the use of the addressee. If you are not the addressee, and have=20
received this message by mistake, please delete it and immediately=20
notify us. You may not copy or disseminate this message to anyone. Thank=20
you.
