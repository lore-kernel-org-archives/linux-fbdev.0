From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
	describing the feature
Date: Sat, 10 Jun 2006 13:01:52 -0400
Message-ID: <9e4733910606101001j1a10eb9x89d4c2b200fe5ba8@mail.gmail.com>
References: <44893407.4020507@gmail.com>
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	<448AC8BE.7090202@gmail.com>
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fp6qS-0001lY-IZ for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 10:01:56 -0700
Received: from nz-out-0102.google.com ([64.233.162.202])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fp6qO-0003pO-LC
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 10 Jun 2006 10:01:53 -0700
Received: by nz-out-0102.google.com with SMTP id z3so972412nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 10 Jun 2006 10:01:52 -0700 (PDT)
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
> The problem with the previous system was that bind(register) and open
> were combined into a single operation when they should be separate. I
> should be able to load four console drivers and then pick the one I
> want to switch to without automatically having the console jump to
> each device as the drivers are loaded.

I should clarify this, take_over_console() combines the registration
and open operations. If I loaded four console drivers using
take_over_console() my console would bounce from device to device as
the drivers are loaded. The real problem with the take_over_console()
implementation was that it effectively made loading console drivers
into a stack operation instead of a set operation.

take_over_console() is not incompatible with the scheme I described in
the previous mail if the implementation is changed inside console.
The new implementation would just call the register and open
operations as described earlier. When loading four consoles using
take_over_console() you would still bounce through the four consoles
but once loaded the console drivers would act as a set. You could use
sysfs to switch to any of the registered consoles. If a console driver
is not open it could be unloaded in any order.

Long term I think take_over_console() should be deprecated in favor of
a register(bind) call from the console driver and an explicit sysfs
action to move the console.

-- 
Jon Smirl
jonsmirl@gmail.com
