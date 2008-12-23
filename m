From: =?iso-8859-15?q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [RFC 2.6.27 2/2] mach-pxa: add AM300 platform driver
Date: Tue, 23 Dec 2008 10:24:37 +0100
Message-ID: <18768.44629.937505.213868@ipc1.ka-ro>
References: <12298571881580-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70812230047g54cae195g8cf6297783d2602c@mail.gmail.com>
Content-Type: multipart/mixed; boundary="===============1040446154=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <f17812d70812230047g54cae195g8cf6297783d2602c@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Eric Miao <eric.miao@marvell.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

--===============1040446154==

Hi,

Eric Miao writes:
> On Sun, Dec 21, 2008 at 6:59 PM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> > This patch adds support for the AM300 platform driver.
> >
> 
> Patch looks good, I feel I'm nit-picking. Anyway , see my comments below:
> 
[...]
> > +static int am300_wait_for_rdy(struct broadsheetfb_par *par)
> > +{
> > +       unsigned long flags;
> > +       DEFINE_WAIT(wait);
> > +
> > +       spin_lock_irqsave(par->lock, flags);
> > +       while (!gpio_get_value(RDY_GPIO_PIN)) {
> > +               prepare_to_wait(&par->waitq, &wait, TASK_INTERRUPTIBLE);
                                                             ^^^^^^^^^^^^^
This should be TASK_UNINTERRUPTIBLE, or the case of an interrupted
wait need to be handled in some way!

> wait_event() might be the perfect choice for the above case, unless your
>
... which would also fix the above bug.


Lothar Wa���mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra���e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch���ftsf���hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============1040446154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--===============1040446154==--
