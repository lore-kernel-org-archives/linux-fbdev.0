From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Fri, 09 Dec 2005 09:17:36 +1100
Message-ID: <1134080257.11760.19.camel@gaston>
References: <1133944427.7168.70.camel@gaston>  <43989DA3.8070602@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkU7i-0004qX-3J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 14:20:22 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1EkU7g-0007oJ-Ew
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 14:20:21 -0800
In-Reply-To: <43989DA3.8070602@gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Andrew Morton <akpm@osdl.org>

On Fri, 2005-12-09 at 04:54 +0800, Antonino A. Daplas wrote:
> Benjamin Herrenschmidt wrote:
> > Recent X "nv" driver was fixed for various issues with modern 6xxx and
> > 7xxx cards. This patch ports those fixes to nvidiafb. This makes it work
> > fine on the 6600 bundled with the newest G5 macs. I've verified it still
> > works on the 5200FX of the iMacG5.
> 
> Yes, I have a similar patch in my tree but I'm waiting for people to verify
> the patch.
> 
> (And I have I more patch for pci-e cards, and still waiting for testers
> to respond.)

Can you send me your version of the patch ? I spotted a couple of bugs
in your previous code, I want to make sure it's all fixed :)

Ben.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
