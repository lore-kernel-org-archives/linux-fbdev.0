From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Card's view of framebuffer offset i
Date: Mon, 15 Jul 2002 11:09:26 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <AF4348F5A21@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: Quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17U1rZ-0007mN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 15 Jul 2002 02:09:49 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Ville Syrjaelae <syrjala@sci.fi>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 15 Jul 02 at 4:56, Ville Syrj=E4l=E4 wrote:
> On Mon, Jul 15, 2002 at 02:02:14AM +0200, Petr Vandrovec wrote:
> > On Sun, Jul 14, 2002 at 04:10:29PM +0300, Ville Syrj=E4l=E4 wrote:
> > > Is there a way to ge the framebuffer offset to userspace? I hacked
> > > DirectFB to draw to the crtc2 display but currently I've had to hard=
code
> > > the framebuffer offset. So I need something I can feed to tmy G400.
> > 
> > In what environment? With matroxfb you have special framebuffer which
> > is displayed by CRTC2 engine.
> 
> > Offset is not explicitly exported, but
> > if you'll take low 24 bits from fb_start, you'll get offset on
> > G400/G450/G550 devices.
> 
> I don't see such a thing anywhere. Do you mean smem_start? Ok just tried
> with (smem_start + offset & 0x1ffffff) and it works for both heads. So
> that's actually 25 bits. Maybe I should just use 28 bits to accomodate
> larger framebuffers?

No. You must use exactly 25 bits on G400/G450/G550 series, because of
upper 7 bits are random: framebuffer apperture is 32MB on them, and upper
7 bits specify framebuffer position in PCI MMIO address space.
                                                Petr Vandrovec
                                                


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
