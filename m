From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] fb: add support for foreign
 endianness
Date: Sun, 17 Feb 2008 10:44:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802171030330.6848@anakin>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JQg4j-0001d6-Sz for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Feb 2008 01:44:45 -0800
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JQg4i-0004Tu-6q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 17 Feb 2008 01:44:45 -0800
In-Reply-To: <20080215164542.GB16810@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: avorontsov@ru.mvista.com, linux-fbdev-devel@lists.sourceforge.net
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Fri, 15 Feb 2008, Anton Vorontsov wrote:
> On Thu, Feb 14, 2008 at 10:49:42PM -0800, Andrew Morton wrote:
> > On Tue, 5 Feb 2008 18:44:32 +0300 Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> > > This patch adds support for the framebuffers with non-native
> > > endianness. This is done via FBINFO_FOREIGN_ENDIAN flag that will
> > > be used by the drivers. Depending on the host endianness this flag
> > > will be overwritten by FBINFO_BE_MATH internal flag, or cleared.
> > > 
> > > Tested to work on MPC8360E-RDK (BE) + Fujitsu MINT framebuffer (LE).
> > 
> > That's a pretty large patch to fbdev core,
> 
> Yes, but changes are mostly trivial. No insurance of typos and thinkos
> though. OTOH, it survived my tests.
> 
> > and Tony appears to have gone
> > offline again and you didn't cc the fbdev mailing list.
> 
> FRAMEBUFFER LAYER
> P:      Antonino Daplas
> M:      adaplas@gmail.com
> L:      linux-fbdev-devel@lists.sourceforge.net (subscribers-only)
> 
> I'm lazy to subscribe on occasional patches. Yup, this is hardly
> an excuse...

While linux-fbdev is subscribers-only, non-subscribers are not plainly
rejected, but moderated, so the casual patch/comment/question comes
through.

I'll cook up a patch for MAINTAINERS to clarify.

> > Actually...  should CONFIG_FB_FOREIGN_ENDIAN exist, or should this feature
> > be permanently enabled?
> 
> It should not. Because with CONFIG_FB_FOREIGN_ENDIAN enabled, drawing
> might be a little bit slower, because of external checks for endianness
> (I didn't noticed any slowdown, but I guess it's still measurable if we
> find some fb benchmark).

> > I'd like to at least queue a patch in -mm so that CONFIG_FB_FOREIGN_ENDIAN
> > is forced-on, so the code gets some runtime testing.  Will that break
> > anything?
> 
> Nope, it should not break anything, just possible fbconsole/tux drawing
> slowdown.

Tux drawing speed doesn't really matter, as it's done once only.
Console text drawing is different.

`time cat MAINTAINERS' is a good test. Of course, is most time is spent
in scrolling, you won't see much difference.

So probably we need a test file that contains lines of text interspersed
with `HOME' escape sequences, so we don't scroll?

> Thinking about it a little bit more, I believe we want to add a choice,
> which exactly foreign endianness we want to compile-in. Then, if we're
> pretty confident that particular BE machine uses only LE framebuffer,
> gcc can optimize away endianness checks.
> 
> Patch on top of previous inlined here. With that patch, slowdown is
> possible with CONFIG_FB_BOTH_ENDIAN option only, which is still
> default if FOREIGN_ENDIAN is selected.
> With this patch FB_FOREIGN_ENDIAN converted to menuconfig with the
> choice inside: which type of foreign endianness we want to compile-in.
> 

The notion of `FOREIGN_ENDIAN' is relative, as it depends on the
architecture you're compiling for.

Suppose you have a PCI graphics card with a frame buffer that's always
big endian. When compiling for a big endian platform, the driver won't
depend on FB_FOREIGN_ENDIAN. When compiling for a little endian
platform, it will.

Shouldn't we add LITTLE_ENDIAN and BIG_ENDIAN Kconfig vars first, just
like we have 64BIT?

> As a bonus, now fb subsystem will refuse to register framebuffer with
> unsupported endianness, and will suggest a way to solve the problem.

I'd like to handle this in Kconfig (cfr. above).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
