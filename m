From: "Carlo E. Prelz" <fluido@fluido.as>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Sun, 13 Oct 2002 17:14:19 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013151419.GA13649@casa.fluido.as>
References: <20021012153641.GA13798@casa.fluido.as> <20021013001324.GF4267@ppc.vc.cvut.cz> <20021013141516.GA9973@casa.fluido.as> <20021013145604.GC20348@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from a205017.upc-a.chello.nl ([62.163.205.17] helo=mail.fluido.as)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180kRu-0002vw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 08:14:35 -0700
Content-Disposition: inline
In-Reply-To: <20021013145604.GC20348@ppc.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

	Subject: Re: Mixing g400 dualhead and old Millennium.
	Date: dom, ott 13, 2002 at 04:56:04 +0200

Quoting Petr Vandrovec (vandrove@vc.cvut.cz):

> Strange, I'll have to look at 2.4.20-pre10-ac2 then. I do not
> remember sending anything special for 2.4.20 to Alan...

Pre10-ac2 has a matroxfb_base.c with Version: 1.64 2002/06/10. Simple
pre10 has Version: 1.62 2001/11/29.

> > matroxfb_crtc2: secondary head failed to register
> > matroxfb_crtc2: CRTC2 framebuffer failed to register
> 
> It can only happen if there is not enough memory (uh...) or if
> register_framebuffer() fails. And only way I can imagine is
> that you run out of possible framebuffers... Can you
> verify that /usr/src/linux/include/linux/fb.h contains
> '#define FB_MAX 32' and not some small value like '2' ?

Both versions have 32. 

> If you could print return value from register_framebuffer in 
> matroxfb_dh_regit in matroxfb_crtc2.c, maybe it could reveal
> problem. Maybe that using non-ac kernel fixes problem too.

I will add a printk & will let you know.

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
