From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Sun, 13 Oct 2002 16:56:04 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013145604.GC20348@ppc.vc.cvut.cz>
References: <20021012153641.GA13798@casa.fluido.as> <20021013001324.GF4267@ppc.vc.cvut.cz> <20021013141516.GA9973@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p0314.as-l042.contactel.cz ([194.108.238.60] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 180kAL-0001rC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 07:56:26 -0700
Content-Disposition: inline
In-Reply-To: <20021013141516.GA9973@casa.fluido.as>
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
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Sun, Oct 13, 2002 at 04:15:16PM +0200, Carlo E. Prelz wrote:
> 
> I was having problems in compiling things in kernel. Eventually, it
> seems they were limited to compiling the latest 2.4.20-pre10-ac2
> patch, which contains a more recent version of your material. With
> that, both with modules and included in the kernel, I get the
> following messages (here with modules);

Strange, I'll have to look at 2.4.20-pre10-ac2 then. I do not
remember sending anything special for 2.4.20 to Alan...

> matroxfb_crtc2: secondary head failed to register
> matroxfb_crtc2: CRTC2 framebuffer failed to register

It can only happen if there is not enough memory (uh...) or if
register_framebuffer() fails. And only way I can imagine is
that you run out of possible framebuffers... Can you
verify that /usr/src/linux/include/linux/fb.h contains
'#define FB_MAX 32' and not some small value like '2' ?

> so that I cannot see the second head of the g400. With 2.4.19 and
> module loading, instead of the last two lines I get:
> 
> matroxfb_crtc2: secondary head of fb1 was registered as fb2
> 
> This is not urgent for me now. I still cannot see if the output is
> present on all outputs (somebody will have to physically check the
> monitor outputs, and that will hopefully happen sometimes tomorrow),
> but now the matroxset output looks very promising. 
> 
> In all cases, if you want me to do some tests or try some patch to see
> if the 'failed to register' situation can be fixed, just ask.

If you could print return value from register_framebuffer in 
matroxfb_dh_regit in matroxfb_crtc2.c, maybe it could reveal
problem. Maybe that using non-ac kernel fixes problem too.
						Petr Vandrovec
						vandrove@vc.cvut.cz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
