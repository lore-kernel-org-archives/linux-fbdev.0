From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Re: FBDEV 2.6.0-test7 updates.
Date: Fri, 17 Oct 2003 13:10:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031017111032.GB1639@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org> <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org> <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston> <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston> <20031017100412.GA1639@casa.fluido.as> <1066387778.661.226.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AASWl-0006Xf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 04:12:16 -0700
Received: from a205017.upc-a.chello.nl
	([62.163.205.17] helo=mail.fluido.as ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AASW7-0004Rx-Gr
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Oct 2003 04:11:36 -0700
Content-Disposition: inline
In-Reply-To: <1066387778.661.226.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

	Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
	Date: ven, ott 17, 2003 at 12:49:38 +0200

Quoting Benjamin Herrenschmidt (benh@kernel.crashing.org):

> Not sure what's up here. The driver is quite passive regarding
> the mode for other VCs, it sort of expect the fbcon layer do pick up
> the default mode and use it for other consoles. I'm not sure what's
> wrong here.
> 
> In a more general way, I really lack the ability to change the console
> size with fbset like I could do with 2.4. I don't know if James revived
> that feature in his latest patches though. The stty thing isn't very
> reliable imho. Especially on monitors that don't like the standard
> modedb.

fbset really does a great mess, if mixed up with stty. It took me
almost an hour to find the right combination. Now, I have a stable
system, apart from the fact of having to do blind termnal setup for
each VC...

> > And on a similar topic, could you write a couple of examples about how
> > to use the parameters included in radeon_base.c? I am thinking
> > especially of the "mirror" and "monitor_layout" parameters, that I
> > believe would allow me to use the two or three video outputs of the
> > card independently. I currently read
> 
> I have to see what I'll do of these parameters first. For now, the
> driver only really use the first head. I haven't yet implemented support
> for the second one, though it's on my list of things to do.

Aha... So, from what you know, is there any possibility (fb, X, X with
ATI drivers, anything else) to use the video output (or the second
head) of radeon cards under Linux? And have you tried your drivers
with 2 cards (one PCI and one AGP)?

And in all cases, why is parameter "mode" not working? If I could set
1280x1024-32@60 from Lilo, most of my problems would be solved...

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
