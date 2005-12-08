From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] nvidiafb: Fix 6xxx/7xxx cards
Date: Fri, 09 Dec 2005 06:54:13 +0800
Message-ID: <4398B995.6000903@gmail.com>
References: <1133944427.7168.70.camel@gaston>  <43989DA3.8070602@gmail.com> <1134080257.11760.19.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkUea-00077E-Mr
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 14:54:20 -0800
Received: from xproxy.gmail.com ([66.249.82.192])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkUea-0000Fq-Ie
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 14:54:20 -0800
Received: by xproxy.gmail.com with SMTP id s6so515433wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Dec 2005 14:54:18 -0800 (PST)
In-Reply-To: <1134080257.11760.19.camel@gaston>
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

Benjamin Herrenschmidt wrote:
> On Fri, 2005-12-09 at 04:54 +0800, Antonino A. Daplas wrote:
>> Benjamin Herrenschmidt wrote:
>>> Recent X "nv" driver was fixed for various issues with modern 6xxx and
>>> 7xxx cards. This patch ports those fixes to nvidiafb. This makes it work
>>> fine on the 6600 bundled with the newest G5 macs. I've verified it still
>>> works on the 5200FX of the iMacG5.
>> Yes, I have a similar patch in my tree but I'm waiting for people to verify
>> the patch.
>>
>> (And I have I more patch for pci-e cards, and still waiting for testers
>> to respond.)
> 
> Can you send me your version of the patch ? I spotted a couple of bugs
> in your previous code, I want to make sure it's all fixed :)
> 

I already told akpm to drop mine and take yours instead as you already
verified that it works.  I'll send you the pci-e support patch, diffed
against your patch if you want.

Tony


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
