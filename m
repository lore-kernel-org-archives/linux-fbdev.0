From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Small API change
Date: Tue, 1 Apr 2003 22:10:59 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0304012207040.25096-100000@vervain.sonytel.be>
References: <1049221857.589.138.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 190S7g-0000Lz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Apr 2003 12:12:44 -0800
In-Reply-To: <1049221857.589.138.camel@zion.wanadoo.fr>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Antonino Daplas <adaplas@pol.net>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 1 Apr 2003, Benjamin Herrenschmidt wrote:
> I want to add a flag passed by userland in fb_var_screeninfo
> that say, for an LCD using a scaled mode, to either use a full
> scaling or to keep aspect ratio (when possible).
> 
> This is quite useful for things like titanium powerbooks with their
> wide LCDs. Currently, if I set a 1024x768 mode on my 'native' 1152x768,
> I get a horizontal scaling and no vertical scaling, thus a bad
> aspect ratio. It can be ok for some things, not for others, I'd like
> to let userland the choice. MacOS does provide both set of modes
> as well. In the "keep aspect ratio" mode, the driver would scale
> both H and V the same (based on the smaller of H and V ratios)
> and add margins to center the display. On some radeons, I think I
> even have optional HW automatic centering.
> 
> We can either define a "flags" field using on of the reserved ones
> and stuff that (along with 31 remaining bits for whatever other
> flags we may have, I'm thinking about 6 vs. 8 bits DACs or such
> other options that are common to enough HW to be worth defining
> there).
> 
> We can define a "hw_specific_flags" field. Same as above, but we
> define the meaning of this field as depending on the driver. That
> is, we add a way for userland to pass mode attributes (we are really
> talking about mode attributes here, that should be passed along with
> setting the mode) that are specific to a given driver, though the
> problem of identifying the driver type may not be that simple (using
> the accel type constant ?)
> 
> Or we can eventually just define a new bit in the "sync" field, that
> seem to be the most economic way, since we have 32 bits available
> and only 6 used so far

I think the vmode field is better suited for this than the sync field.

Do you want a `positive' (keep aspect ratio) or `negative' (allow stretching)
flag? And what about stretching that doesn't involve changing the aspect ratio?
E.g. do you want 640x480 to be stretched to 1024x768, or not stretched and
centered?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
