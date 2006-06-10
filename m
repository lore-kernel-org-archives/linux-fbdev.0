From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2/5] VT binding: Add sysfs support
Date: Sat, 10 Jun 2006 08:38:18 +0800
Message-ID: <448A147A.3030108@gmail.com>
References: <448933D7.6040301@gmail.com> <20060609220803.GB7636@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ForUi-0000I9-J8 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Jun 2006 17:38:28 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1ForUh-0000FD-Pf
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Jun 2006 17:38:28 -0700
Received: by py-out-1112.google.com with SMTP id x31so1117481pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 Jun 2006 17:38:27 -0700 (PDT)
In-Reply-To: <20060609220803.GB7636@suse.de>
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
To: Greg KH <gregkh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Greg KH wrote:
> On Fri, Jun 09, 2006 at 04:39:51PM +0800, Antonino A. Daplas wrote:
>> Add sysfs attributes for binding and unbinding VT console drivers. The
>> attributes are located in /sys/class/tty/console and are namely:
>>
>>     A. backend - list registered drivers in the following format:
>>
>>     "I C: Description"
> 
> No, this violates the "one value per file" issue with sysfs.  How do you
> know you will not overflow the buffer passed to you?

I was wondering about this. I just want a way to show what are the currently
loaded drivers, so it's a read-only attribute.  It's using snprintf (though
I haven't added a check for possible overflows, should be a 2-liner). Maximum
number of lines is 16, and there are examples of this rule-breakage in the
current sysfs tree.

/sys/class/usb_host/usb_hostx/device/pools

Yes, none are valid excuses.  Anyway, what would be the best way? I was
considering creating another class for vt_console, but that would entail
the creation of a new device major number just for this.

> 
>>     Where: I  = ID number of the driver
>>            C  = status of the driver which can be:
>>
>> 		S = system driver
>> 		B = bound modular driver
>> 		U = unbound modular driver
>>
>> 	   Description - text description of the driver
>>
>>     B. bind - binds a driver to the console layer
>>
>>        echo <ID> > /sys/class/tty/console/bind
>>
>>     C. unbind - unbinds a driver from the console layer
>>
>>        echo <ID> > /sys/class/tty/console/unbind
>>
>> The tty layer does nothing to these attributes except create them and punt all
>> requests to the VT layer.
> 
> Why is this needed?  What is wrong with the current scheme of binding
> ttys to the console?
> 

The binding part, maybe none, but that's still debatable.  It's the unbinding
feature that people are requesting.  Note the longish threads on "the future
of graphics subsystem".  It would also ease the life of console driver
developers, and it would stop people from pestering me on why they cannot unload
their beloved framebuffer console and drivers and go back to VGA console.

Tony
