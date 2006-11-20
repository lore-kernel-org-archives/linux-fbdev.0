From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: Re: 2.6.19-rc5: Geode GX frame buffer takes 13
 seconds to initialize
Date: Mon, 20 Nov 2006 10:06:26 -0700
Message-ID: <20061120170626.GB6721@cosmic.amd.com>
References: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GmIL1-0001HT-FU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 15:14:07 -0800
Received: from outbound-blu.frontbridge.com ([65.55.251.16]
	helo=outbound3-blu-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GmIKz-0001wQ-NT
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Nov 2006 15:14:07 -0800
In-Reply-To: <808c8e9d0611160829k28a8fdf9mafb9c7e27163cf4b@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Gardner <gardner.ben@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 16/11/06 10:29 -0600, Ben Gardner wrote:
> Hi all,
> 
> I'm using the Geode GX processor and the associated frame buffer
> driver in 2.6.19-rc5.
> I have a 640x480 LCD attached, without DDC support (not sure if that 
> matters).
> 
> The frame buffer driver takes 12.5 seconds to initialize.
> 
> Is this normal?

It shouldn't be.  We're beating the stuffing out of this driver for the 
OLPCs, and people certainly would have complained loudly if it didn't work.  
We are building it in (rather then as a module) so its not exactly an 
equivalent test.

Can you get any indication of where the break down is happening during
the init sequence?

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
