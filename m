From: Luc Verhaegen <libv@skynet.be>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/9] viafb: VIA Frame Buffer Device Driver - Resend
Date: Fri, 16 May 2008 22:22:28 +0200
Message-ID: <20080516202228.GA15817@skynet.be>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F67745@exchtp03.taipei.via.com.tw> <20080507184333.7d0f1bf4.krzysztof.h1@poczta.fm> <20080508081508.GD11121@localhost.localdomain> <Pine.LNX.4.64.0805081452120.8604@anakin>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760616AbYEPUWi@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0805081452120.8604@anakin>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ondrej Zajicek <santiago@crfreenet.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, JosephChan@via.com.tw, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thu, May 08, 2008 at 02:52:34PM +0200, Geert Uytterhoeven wrote:
> On Thu, 8 May 2008, Ondrej Zajicek wrote:
> > On Wed, May 07, 2008 at 06:43:33PM +0200, Krzysztof Helt wrote:
> > > PS. I assume that your driver will replace the existing vt8623fb (CLE266?) driver when ready. Am I right?
> > 
> > These drivers are hardly comparable. vt8623fb supports CLE266 with VGA output only,
> > but allows arbitrary resolutions and pixclocks, high-res text mode and
> > (partially) suspend/resume. viafb implements fixed resolutions only and
> > have no text mode and no suspend/resume support (according to my quick
> > look on it).
> 
> It's a pity viafb implements fixed resolutions only. Is there any
> specific reason for that?
> 
> Gr{oetje,eeting}s,
> 
> 						Geert

Known good dotclock parameters versus a routine to generate stable dotclocks
parameters.

Luc Verhaegen.
SUSE/Novell X Driver Developer.
