From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Subject: Re: Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 02:08:09 +0100
Message-ID: <421FCBF9.1020003@XLsigned.net>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org> <20050224145049.GA21313@suse.de> <20050226004137.GA25539@suse.de> <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4qRO-00080z-Co
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:08:18 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D4qRL-0000Oo-1y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:08:18 -0800
In-Reply-To: <Pine.LNX.4.58.0502251648420.9237@ppc970.osdl.org>
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
Cc: Olaf Hering <olh@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>

Linus Torvalds wrote:
> 
> On Sat, 26 Feb 2005, Olaf Hering wrote:
> 
>>modedb can not be __init because fb_find_mode() may get db == NULL.
>>fb_find_mode() is called from modules.
> 
> 
> Ack. Maybe somebody should run the scripts again to check that we don't 
> reference __init data from non-init functions.
> 
> 		Linus
> 
This patch has already been posted to linux-fbdev on 2005-02-10 by David Vrabel
and made me ask
	Is there any reason why this has been originally flagged "__init"?
	"vesa_modes" is not "__init". That's why I changed "intelfb" to
	use "vesa_modes".

Maybe time has come to decide, if availability of "modedb" outside
of init functions is more important than freeing (unused) kernel memory.

--Axel



  

  


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
