From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: tdfx framebuffer garbles display in 2.6.19.5
Date: Tue, 06 Mar 2007 09:33:37 +0800
Message-ID: <1173144817.7219.1.camel@daplas>
References: <20070226144744.GA3615@DervishD>
	<1172503471.20842.14.camel@daplas> <20070226171334.GB13496@DervishD>
	<1172510654.7101.11.camel@daplas> <20070226203223.GA161@DervishD>
	<1172617755.13422.0.camel@daplas>  <20070301160139.GA102@DervishD>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOOWr-0001M7-7E for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 17:31:51 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOOWo-0004Dz-BI
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 17:31:49 -0800
Received: from nz-out-0506.google.com ([64.233.162.235])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1HOOWl-0003CH-Ri for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 17:31:45 -0800
Received: by nz-out-0506.google.com with SMTP id i11so2909272nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 05 Mar 2007 17:31:43 -0800 (PST)
In-Reply-To: <20070301160139.GA102@DervishD>
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
To: DervishD <lkml@dervishd.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux-kernel <linux-kernel@vger.kernel.org>

On Thu, 2007-03-01 at 17:01 +0100, DervishD wrote:
>     Hi Antonino :)
> 
>  * Antonino A. Daplas <adaplas@gmail.com> dixit:
> > Can you try this patch?  It might help with the screen corruption.
> 
>     With the patch, the scroll slows to a crawl and the system is
> unusable. The time to scroll 30 lines is about a minute or so (probably
> more, I just measured for a while).
> 
>     If you want me to test other patches, just tell :)

Can you change the mdelay to udelay and use higher/lower delay values to
see if there's any improvement?

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
