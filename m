From: "Richard Purdie" <rpurdie@rpsys.net>
Subject: w100 fb driver
Date: Fri, 19 Nov 2004 16:51:46 -0000
Message-ID: <021601c4ce58$1111a730$0f01a8c0@max>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVBzK-0000oB-Qx
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 08:51:58 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CVBzI-0006N1-T9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 08:51:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iAJGpleg027569
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 16:51:47 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 27091-10 for <linux-fbdev-devel@lists.sourceforge.net>;
 Fri, 19 Nov 2004 16:51:47 +0000 (GMT)
Received: from max (max.rpnet.com [192.168.1.15])
	(authenticated bits=0)
	by tim.rpsys.net (8.12.10/8.12.10) with ESMTP id iAJGpilW027548
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 16:51:44 GMT
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
Content-Type: text/plain; format="flowed"; charset="us-ascii"; reply-type="original"
To: linux-fbdev-devel@lists.sourceforge.net

I've been working on creating support for the Sharp SL-C7xx series as part 
of a wider effort to create support for the whole Zaurus range of PDAs under 
linux 2.6. The C7xx's contain the ATI w100 video chip which doesn't have 
mainstream kernel support at present.

Sharp did release a driver against 2.4.18 and I've ported this across to the 
2.6 series. I've also made some fairly large changes to the driver to tidy 
it up and create support for certain video modes Sharp never enabled.

I'd like to discuss whether it'd be possible to include this driver in a 
future kernel? The driver is available at: 
http://www.rpsys.net/openzaurus/w100-r1.patch .

I'm aware the corgi_backlight file included above is out of place and it 
will be moved into the arch/arm/mach-pxa folder. I'm also aware some fb 
changes made in 2.6.10-rc2 need to be applied to this file. Are there any 
other problems with the driver as it stands that would prevent its 
inclusion, or areas in the driver that it would be advisable to 
change/improve?

If the driver would be acceptable, what method of submission is preferred? 
(the sourceforge pages seem inactive)

Thanks,

Richard



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
