From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Framebuffer console not working with matroxfb on 2.6
Date: Wed, 15 Sep 2004 13:06:14 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3A062D740E2@vcnet.vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Xas-0007Gd-Vl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Sep 2004 04:04:58 -0700
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C7Xar-0001fZ-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Sep 2004 04:04:58 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 15 Sep 04 at 8:09, Michal 'hramrach' Suchanek wrote:
> I tried using the framebuffer console with matroxfb on a 2.6 kernel and
> I see only reddish pattern on the screen. I do not get any letters.
> However, I can run X with UseFBdev option and a directfb program.
> I can also use the fbcons on an iMac with atifb.
> Tested with 2.6.7, with 2.6.8.1 I still do not get usable fbcons.
> THe hardware is G400 and G550.

Your .config ?  You either did not build fbcon to the kernel or
you are using modular matroxfb.  You cannot do that.
                                                    Petr
                                                    



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
