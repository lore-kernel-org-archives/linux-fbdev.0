From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: 2.5.71, fbconsole: No boot logo?
Date: Tue, 17 Jun 2003 12:58:05 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3EEF489D.4050303@myrealbox.com>
References: <49AA33D2A8D@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19SJqL-0004aA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 17 Jun 2003 10:02:01 -0700
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 19SJpD-0003do-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 17 Jun 2003 19:00:51 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Petr Vandrovec wrote:
> On 16 Jun 03 at 20:53, Flameeyes wrote:
> 
>>On Mon, 2003-06-16 at 20:39, ismail (cartman) donmez wrote:
>>
>>>Try  Graphics support  --->Logo configuration  --->[*] Bootup logo
>>
>>You can't activate the 224 colors logo without Bootup Logo active.
>>I have the same problem with these lines in .config
>>
>>CONFIG_LOGO=y
>>CONFIG_LOGO_LINUX_MONO=y
>>CONFIG_LOGO_LINUX_VGA16=y
>>CONFIG_LOGO_LINUX_CLUT224=y
> 
> 
> It is probably some uninitialized value or something like that.
> 
> At work I have no logo, while at home I have logo (both 2.5.71 from
> yesterday), both with matroxfb... Only significant difference I know
> is that at home I have UP kernel, while at work I have SMP. But it should 
> not matter, yes?

I see the same problem on my smp box with a G450.  Speaking of which, 
this stripped down driver really bites.  This is no offense to Petr, 
since I *know* it isn't his fault that he was restricted by the new 
fbdev API.  James, can't you compromise with Petr on a few of your 
changes so that the missing original, fully featured matroxfb driver 
bits can be merged.  It is kind of insane to have 2.6 actually be worse 
than 2.4 in regards to a very popular and traditionally well-supported 
driver.  If not, I do hope that Petr will continue to supply a side 
patch for this (as time permits him to do so)...

Cheers,
Nicholas




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
