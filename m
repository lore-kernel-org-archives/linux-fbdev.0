From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sat, 10 Jun 2006 13:22:50 -0400
Message-ID: <9e4733910606101022l331ebb11na4c379d88601b674@mail.gmail.com>
References: <44893407.4020507@gmail.com>
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	<448AC8BE.7090202@gmail.com>
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fp7Ah-0003Y4-Up for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 10:22:51 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fp7Ah-0006NC-OC for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 10:22:51 -0700
Received: from nz-out-0102.google.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fp7Ah-0005lt-Gz
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 10:22:51 -0700
Received: by nz-out-0102.google.com with SMTP id z3so975127nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 10:22:50 -0700 (PDT)
In-Reply-To: <9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> I may be looking at the problem a little differently. I see the
> drivers like fb, vga, etc as registering with the console and saying
> they are capable of providing console services. I then see the console
> system as opening one of the registered devices. A driver is free to
> register/unregister whenever it wants to as long as it isn't open by
> the console system. Console can only open one driver at a time.
> Opening another driver automatically closes the previous driver and
> one driver always has to be open.

An example might help clarify this.

Imagine that you have three console drivers (vga, serial, fb) and one
console system all implemented as modules. I'm not saying make console
a module, just pretend like it is one.

First you would modprobe in the console system.
Next modprobe in the three console drivers which automatically
register with the console system.

At this point the console system would have a ref count of 3. It can
not be unloaded until the three console drivers have unregistered.

Now console opens the vga console driver, that will increment the ref
count on that driver.

Now switch to the serial driver, ref count will go to zero on vga and
one one serial.

At this point vga and fb could be unloaded if they were modules.

If console contains the rule that it always has to keep a console
open, it will be bound into memory since it will never be possible to
get its ref count to zero.

In the old model take_over_console() effectively combined these refs
counts so that it was impossible to unload anything once it was
loaded. There was no mechanism to decrement the ref count on the
console drivers.


-- 
Jon Smirl
jonsmirl@gmail.com
