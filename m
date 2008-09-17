From: Alessio Sangalli <alesan@manoweb.com>
Subject: Re: Implementing new fb driver
Date: Wed, 17 Sep 2008 10:14:39 -0700
Message-ID: <48D13AFF.3050803@manoweb.com>
References: <20080917133444.11D82CF1A0@f21.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kg0bV-0002lc-58 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Sep 2008 10:14:13 -0700
Received: from moutng.kundenserver.de ([212.227.126.171])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kg0bT-0001b7-GO
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Sep 2008 10:14:13 -0700
In-Reply-To: <20080917133444.11D82CF1A0@f21.poczta.interia.pl>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: krzysztof.h1@poczta.fm
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

krzysztof.h1@poczta.fm wrote:

>> the fb API unable to deal with this? I have read only 1-bit cursor
>> images are supported.
>>
> 
> No. Look at the include/linux/fb.h
[...]
> You can set colormap for the cursor. 

Umh... I really have to go and get more details, this part of the driver
is the one I do not really understand well. You mean colormap as in
'palette'? or as in 'bitmap'; this hardware will only support truecolor.

> There is only one function to handle cursor (fb_cursor) which set appropriate properties based on set flags (the constants above). 
> One file I fixed cursor handling is the tdfxfb driver (look there).


I will thank you.

Bye
as


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
