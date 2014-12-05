From: David Ung <davidu@nvidia.com>
Date: Fri, 05 Dec 2014 20:07:50 +0000
Subject: RE: [PATCH 3/3] video: fbdev: Validate mode timing against monspec
Message-Id: <7dfb0ced84df4fc6b3a5f7c665f3afb1@HQMAIL102.nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-3-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-3-git-send-email-davidu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

 
> On 03/12/14 23:49, David Ung wrote:
> > fbmon may generate mode timings that are out of spec of the monitor.
> > eg DELL U2410 has a max clock 170mhz but advertises a resolutions of
> > 1920x1200@60 in its Standard Timings, fbmon creates a mode using the
> > GTF timing calculation which gave it a 193mhz clock.
> 
> The above is not exactly true with the previous patches, as fbmon doesn't
> calculate it with GTF, but looks it up from the DMT table.

Aiye.  that was the original problem before the existence of the DMT table.
I can adjust the commit message to add comments below.


> I have to say it's quite odd that the monitor advertises a mode it cannot
> display...

It does support 1920x1200, but with reduced timings (like most modern panels)
What it really want is DMT 0x44 which is reduced timing version of 1920x1200
(0x44, 0x0000, 0x572821, &vesa_modes[34])

But there is no STD 2byte code for this, so it uses 0xd100 in the edid,
which gave it 193mhz


> > This patch checks to see if the mode can be supported by the monitor
> > by comparing against monspecs.dclkmax.
> 
> I don't know about this patch... It looks a bit messy, and only handles a too
> high clock in the get_std_timing. We could as well get bad timing from
> get_est_timing() or somewhere else.
> 
> And I don't know if get_std_timing() should even do such filtering in the
> first place. I'd say it's supposed to return the mode from the EDID block.
> Whether the monitor or the device actually supports the mode is a separate
> thing.

I agree that the EDID block should be correct.  But as I explained above, it's
not always correct and the dclkmax is there to combat one of these situations.
Yes, it will not solve all cases but it's a start.  Hopefully these wrong edid
cases don't occur that often.


> Also, generally speaking, while I have no objection in fixing bugs in fbdev,
> I'd wish everyone just moved to DRM if at all possible. So if this starts
> turning into a bigger change, with possibilities for regressions, we have to
> consider if the fix is important enough.

Right.  Though not everyone can simply switch to DRM.
I hope this patch will not have much impact on any existing code.  As you already
mention it should only be restricted to high clocks.

David

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
