From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH]: EDID parser
Date: Thu, 3 Apr 2003 18:38:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <51136F3B7C@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 1917kM-0001K6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 03 Apr 2003 08:39:26 -0800
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On  3 Apr 03 at 18:21, Sven Luther wrote:
> On Thu, Apr 03, 2003 at 04:21:14PM +0100, Alan Cox wrote:
> > On Iau, 2003-04-03 at 15:15, Sven Luther wrote:
> > > > Read is not enough. If you have connected one /dev/fbx to two
> > > > monitors, you must find highest common denominator for them, and use
> > > > this one.
> > > 
> > > Err, i don't understand this ? Do you mean you are outputing to two
> > > monitors at the same time ?

Yes. With matroxfb you can output same signal to all three outputs.
It is default if you have g450 or g550 with recent driver.

> > > If that is so maybe you mean, speaking in graphic card terminology, and
> > > not in fbdev one, that you are sharing one common framebuffer between
> > > two outputs, right, possibly doing mirroring tricks or something such ?
> > 
> > Classic example is a SiS 6326 driving monitor and TV. You need to keep the
> > display to TV acceptable ranges.
> 
> You mean, driving both display with the same ramdac ?

See http://www.bglug.ca/matrox_tvout/g450.jpg. Two inputs, three outputs,
and almost any possible connection between them.

                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
