From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH] Re: Devices don't get linked to
	their class.
Date: Tue, 07 Sep 2004 07:56:51 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1094507810.2304.43.camel@laptop.cunninghams>
References: <1094187751.2979.41.camel@laptop.cunninghams>
	 <200409042041.55199.adaplas@hotpop.com>
	 <1094365292.6252.3.camel@laptop.cunninghams>
	 <200409051840.27452.adaplas@hotpop.com>
	 <1094441896.19674.24.camel@laptop.cunninghams>
	 <32016.10.250.10.1.1094456212.squirrel@sq04.pol.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4RWc-0003PU-K8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:59:46 -0700
Received: from relay01.kbs.net.au ([203.220.32.149] ident=8)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4RWb-00005O-Nd
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Sep 2004 14:59:46 -0700
In-Reply-To: <32016.10.250.10.1.1094456212.squirrel@sq04.pol.net>
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi.

On Mon, 2004-09-06 at 17:36, Antonino A. Daplas wrote:
> I'll modify the patch a little bit so struct fb_info has a struct device
> *device.  This way, we need not add a new parameter to
> register_framebuffer(), and we don't need to modify all drivers, only
> those where we can set the device field.

Sounds great. I knew there was more than one way of skinning this cat,
and just went for the simplest :>

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
