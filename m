From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Another problem, seemingly coming f
Date: Wed, 16 Oct 2002 09:00:27 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4BECCE234BB@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mailgw.cvut.cz ([147.32.3.235])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 181iAw-0003wA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Oct 2002 00:01:03 -0700
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
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-fbdev-devel@lists.sourceforge.net, gif@bek.no

On 15 Oct 02 at 22:29, Carlo E. Prelz wrote:
> > > the image that I am attaching has been sent to all three
> > 
> > Unfortunately I do not see anything. I see horizontal black lines
> > on all three monitors, and nothing else...
> 
> I am now adding a version where I underline - with yellow lines - the
> places where these artifacts appear.

Ah, these ones... What pixclocks do you use? It is like if CRTC2 has
not enough memory bandwidth available, and so it displays stale data.
But it looks strange anyway. I'm afraid that I cannot help you,
sorry. You can try experimenting with different pixclocks, different
bit depths, and so on. But I cannot explain why it happens only
when old Millennium is also in the box.
 
> Everything happens as expected. First both good, then both bad, then
> first bad and second good.

So it is really caused by CRTC2, not by Maven. Even more strange, then 
it looks like that CRTC2 bus accesses are only possible source of problem
(it could be also subpicture displayed over picture, but because of
subpicture is YUV, while your corruption is copy of RGB surface, I think
that it is impossible).

Only problem I can think of is that system VCO frequency is always set
to 133333 kHz (for G100/200/400) in matroxfb_DAC1064.c. Your PINS
suggest that 200MHz are correct system clocks for your chip.
                                                    Thanks,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
