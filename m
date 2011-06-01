From: Daniele Salvatore Albano <info@daccii.it>
Date: Wed, 01 Jun 2011 17:19:15 +0000
Subject: Mirror "module" for framebuffer
Message-Id: <4DE67493.6090708@daccii.it>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi to all,

In short i should start to work to an application to remote control an 
android phone, just using the browser (video stream plus a lot of 
javascript).
While this is partially working right now, as you can imagine, phone is 
slow, a lot slow, so, while the framebuffer is little in most cases 
(320x256x2/320x256x4/800x480x2/800x480x4) a simple comparison, using 
neon extension too, if avaiable, is too slow, so the screen is refreshed 
too few times in a sec.

On windows exists Mirror Drivers infrastructure that supply a list of 
changed parts of the screen and more (mouse events too if i'm not 
wrong), but looking around on the web i didn't founded anything related 
to this stuff (or similar) for linux.

So, before i start scrambling docs and source code (i've really little 
experience with kernel module programming, i've done simply things), i 
want to ask a simple question: can be done using a sort of hooking of 
internal framebuffer function calls (fb_ops for example) or it's 
impossible because apps write directly into the framebuffer memory?

Thank you!!!


Best Regards,
Daniele

-- 
____________________________________________________________
                                         |
Daniele Salvatore Albano                | web site:
  IT Consultant                          | http://www.itechcon.it
  Website Design and Development         |
  Software Engineer and Developer        | e-mail:
  Linux Servers SetUp And Administration | info@itechcon.it
  Embedded Network Solutions             | d.albano@itechcon.it

Ai sensi del D.Lgs. 196/2003 si precisa che le informazioni contenute in 
questo messaggio sono riservate ed a uso esclusivo del destinatario. 
Qualora il messaggio in parola Le fosse pervenuto per errore, La 
invitiamo ad eliminarlo senza copiarlo e a non inoltrarlo a terzi, 
dandocene gentilmente comunicazione. Grazie.
Pursuant to Legislative Decree No. 196/2003, you are hereby informed 
that this message contains confidential information intended only for 
the use of the addressee. If you are not the addressee, and have 
received this message by mistake, please delete it and immediately 
notify us. You may not copy or disseminate this message to anyone. Thank 
you.
