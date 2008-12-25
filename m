From: =?iso-8859-15?q?Lothar_Wa=DFmann?= <LW@KARO-electronics.de>
Subject: Re: [RFC 2.6.27 1/2] fbdev: add E-Ink
	Broadsheet controller support v2
Date: Thu, 25 Dec 2008 15:17:25 +0100
Message-ID: <18771.38389.730967.119264@ipc1.ka-ro>
References: <1230209500424-git-send-email-jayakumar.lkml@gmail.com>
Content-Type: multipart/mixed; boundary="===============6663130555106610559=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <LW@KARO-electronics.de>) id 1LFr2D-00086U-So
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Dec 2008 14:17:57 +0000
Received: from mail.karo-electronics.de ([213.146.116.110])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LFr26-0002VO-MA
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 25 Dec 2008 14:17:57 +0000
In-Reply-To: <1230209500424-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Eric Miao <eric.miao@marvell.com>, linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.arm.linux.org.uk

--===============6663130555106610559==

Jaya Kumar writes:
> +static void broadsheet_send_cmdargs(struct broadsheetfb_par *par, u16 cmd,
> +					int argc, u16 *argv)
> +{
> +	int i;
> +
> +	par->board->wait_for_rdy(par);
> +
You should probably check the return value of wait_for_rdy() and
distinguish between:
  == 0 => the GPIO was not found asserted within the timeout period
  < 0  => the wait was interrupted due to a signal
  > 0  => OK
Only in the last case the RDY_GPIO_PIN actually signalled a READY
condition. In the other two cases you might not expect the hardware to
do what you actually want it to do.

Otherwise you should probably better use the plain wait_event()
instead of wait_event_interruptible_timeout() in the wait_for_rdy()
function which only returns when the expected condition has been
found (but may block indefinitely when the condition never occurs).



Lothar Wa���mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra���e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch���ftsf���hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============6663130555106610559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6663130555106610559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============6663130555106610559==--
