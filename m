From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Devices don't get linked to their class.
Date: Sun, 05 Sep 2004 16:21:32 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1094365292.6252.3.camel@laptop.cunninghams>
References: <1094187751.2979.41.camel@laptop.cunninghams>
	 <200409042041.55199.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C3qSS-0007uL-Ec
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 23:25:00 -0700
Received: from relay01.kbs.net.au ([203.220.32.149])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C3qSP-0003KM-GZ
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 04 Sep 2004 23:25:00 -0700
In-Reply-To: <200409042041.55199.adaplas@hotpop.com>
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

On Sat, 2004-09-04 at 22:41, Antonino A. Daplas wrote:
> On Friday 03 September 2004 13:02, Nigel Cunningham wrote:
> > This morning I began work on addressing the problem. I thought the best
> > approach would be to use device classes to find the struct dev for the
> > frame buffer driver, and then use the same code I use for storage
> > devices to avoid suspending the frame buffer until later. I successfully
> > wrote a helper to find the 'graphics' class that fbmem.c creates, but
> > now I've run into a more serious issue. register_framebuffer (in the
> > same time) calls class_simple_device_add with a NULL for the pointer to
> > the struct device. Is it possible for this issue to be addressed? I can
> 
> I guess it's doable, but will require small changes to all framebuffer 
> drivers.  All you need is struct device, right?  Maybe I can brew up a test 
> patch next week.

I'm only just beginning to learn how to use kobjects, so I'm not
entirely sure. Looking more after posting that message, I began to think
that struct class_device (going from memory) might act as equivalent to
a linking table in a many-to-many relationship between classes and
devices. If that's right, perhaps the right thing to do is leave the dev
blank in the class registration and then register a class_device to link
them when the actual driver registers.

Regards,

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
