From: John Zielinski <grim@undead.cc>
Subject: Re: 2.6 fbcon and 15/16 bpp
Date: Wed, 10 Dec 2003 01:43:41 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FD6C09D.50807@undead.cc>
References: <1070348676.4311.39.camel@gaston>  <3FCC4018.4020503@undead.cc>	 <1070403757.4300.75.camel@gaston>  <3FCD17D5.4040804@undead.cc> <1070410792.21174.83.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATy4i-0007KP-PZ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Dec 2003 22:43:56 -0800
Received: from gw-undead3.tht.net ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1ATy4i-0005RM-BH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Dec 2003 22:43:56 -0800
In-Reply-To: <1070410792.21174.83.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Benjamin Herrenschmidt wrote:

>>Little.  It's an single processor Athalon box.  I'll do the test later 
>>tonight as I don't want to reboot the other machine at the moment.
>>    
>>
>
>Ok, so this isn't an endian problem in the cfb_ routines. Thanks.
>I'll try to figure out what's up here as well later this week, I'm
>a bit too busy with other things at the moment.
>
>  
>
The riva driver doesn't have a switch to disable acceleration.  I tried 
changing the source but I keep crashing the machine.

John




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
