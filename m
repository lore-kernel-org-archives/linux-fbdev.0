From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 19:15:42 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030403171542.GD1092@iliana>
References: <51136F3B7C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp3.wanadoo.fr ([193.252.22.27] helo=mwinf0403.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1918Jb-000253-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 03 Apr 2003 09:15:52 -0800
Content-Disposition: inline
In-Reply-To: <51136F3B7C@vcnet.vc.cvut.cz>
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
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Apr 03, 2003 at 06:38:44PM +0200, Petr Vandrovec wrote:
> On  3 Apr 03 at 18:21, Sven Luther wrote:
> > On Thu, Apr 03, 2003 at 04:21:14PM +0100, Alan Cox wrote:
> > > On Iau, 2003-04-03 at 15:15, Sven Luther wrote:
> > > > > Read is not enough. If you have connected one /dev/fbx to two
> > > > > monitors, you must find highest common denominator for them, and use
> > > > > this one.
> > > > 
> > > > Err, i don't understand this ? Do you mean you are outputing to two
> > > > monitors at the same time ?
> 
> Yes. With matroxfb you can output same signal to all three outputs.
> It is default if you have g450 or g550 with recent driver.
> 
> > > > If that is so maybe you mean, speaking in graphic card terminology, and
> > > > not in fbdev one, that you are sharing one common framebuffer between
> > > > two outputs, right, possibly doing mirroring tricks or something such ?
> > > 
> > > Classic example is a SiS 6326 driving monitor and TV. You need to keep the
> > > display to TV acceptable ranges.
> > 
> > You mean, driving both display with the same ramdac ?
> 
> See http://www.bglug.ca/matrox_tvout/g450.jpg. Two inputs, three outputs,
> and almost any possible connection between them.

A, ok, you have the CRTC for which you program the timings and such, and
which can then be connected to the DACS or the TMDS or the video output.

You would need to keep a CRTC to output mapping in this case, and read
the DDC buses on the output, fill a table or something, and when the
user change the output mapping, revalidate the video modes in accord to
that. The mapping would not be a bijective one, but you could have more
than one output for one CRTC, i don't think you can have more than one
CRTC for a given output though. You could simply maintain a list of
outputs for each CRTC, and when you need to validate the mode, you have
to validate it for every output linked to each CRTC.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
