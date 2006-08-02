From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: monochrome framebuffer driver on EDB9307
Date: Wed, 02 Aug 2006 20:30:22 +0800
Message-ID: <44D09ADE.2070503@gmail.com>
References: <BAY12-F78D543C7574811FEA0F99C3520@phx.gbl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1196115827=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G8Frr-00038t-9L for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 05:30:31 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1G8Fro-0008Ut-De
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 Aug 2006 05:30:31 -0700
Received: by py-out-1112.google.com with SMTP id d42so1576215pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 02 Aug 2006 05:30:27 -0700 (PDT)
In-Reply-To: <BAY12-F78D543C7574811FEA0F99C3520@phx.gbl>
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
To: gaof fei <sitman99@hotmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

--===============1196115827==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

gaof fei wrote:
> Dear List,
> 
> I'm with linux-2.6.8 on EDB9307(ep93xx).
> At the moment, the framebuffer driver(ep93xxfb.c) doesn't support
> monochrome mode.
> However, I would like to support the mode.
> What can I do with ep93xxfb.c or anything else?
> 
>> In fbdev parlance, monochrome means black and white and the
>> number of bits per pixel does not matter.
>>
>> (It's possible to have 1-bit but the visual is pseudocolor).
>>
>> Basically, set fix->visual = FB_VISUAL_MONO01 (or MONO10).
>>
>> Then set var->bits_per_pixel and var->{green|red|blue} to the appropriate
>> numbers.  Assuming 1-bit monochrome:
>>
>> var->bits_per_pixel = var->green.length = var->red.length = 
> var->blue.length = 1;
>> var->green.offset = var->red.offset = var->blue.offset = 0;
>>
>> Tony
> 
> Thank you for your reply.
> I set visual to FB_VISUAL_MONO01, and bits_per_pixel is 4.
> However, I don't know how to set the PIXELMODE register and the pallette.
> Any suggestion?

You have to ask someone who has docs for that chipset.

Tony


--===============1196115827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1196115827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1196115827==--
