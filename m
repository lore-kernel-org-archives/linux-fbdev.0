From: Torgeir Veimo <torgeir@pobox.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC
	implementation
Date: Sat, 12 Mar 2005 17:21:58 +0000
Message-ID: <1110648119.5997.100.camel@atlantis.netenviron.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
	 <9e473391050312073314dcb39f@mail.gmail.com>
	 <1110646984.5997.96.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAAJL-00082q-Al
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:21:59 -0800
Received: from orb.pobox.com ([207.8.226.5])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAAJJ-0003Aj-UA
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 09:21:59 -0800
Received: from orb (localhost [127.0.0.1])
	by orb.pobox.com (Postfix) with ESMTP id 81F0B5D
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 12:21:55 -0500 (EST)
Received: from [192.168.1.18] (iampivot.plus.com [81.174.152.151])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by orb.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A9E98B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 12:21:55 -0500 (EST)
In-Reply-To: <1110646984.5997.96.camel@atlantis.netenviron.com>
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

On Sat, 2005-03-12 at 17:03 +0000, Torgeir Veimo wrote:
> On Sat, 2005-03-12 at 10:33 -0500, Jon Smirl wrote:
> > You can't do this without coordination from X and DRM. 
> 
> > Because of these issues WAITFORVSYNC in radeondb has to wait for
> > merged DRM/fbdev to be implemented.
> 
> It's a bit hard to track the merge-dri-and-db work, 

^^ merge-dri-and-fb

-- 
Torgeir Veimo <torgeir@pobox.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
