From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 3/9] VT binding: Make VT binding a
	Kconfig option
Date: Tue, 20 Jun 2006 10:49:17 -0400
Message-ID: <9e4733910606200749uea65b6cs65d0975cde21ba73@mail.gmail.com>
References: <44957026.2020405@gmail.com>
	<9e4733910606191718n74d0bf40na7b0cc3902d80172@mail.gmail.com>
	<44974AC7.4060708@gmail.com>
	<9e4733910606191916i1994d4d1i2ea661e015431750@mail.gmail.com>
	<4497B2B5.4040001@gmail.com>
	<9e4733910606200704n19da7833s6873eb3270fe299e@mail.gmail.com>
	<449806B6.7060309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FshXd-0003At-7P for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:49:21 -0700
Received: from nz-out-0102.google.com ([64.233.162.194])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FshXc-0005cf-9P
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 20 Jun 2006 07:49:21 -0700
Received: by nz-out-0102.google.com with SMTP id z3so144799nzf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 20 Jun 2006 07:49:17 -0700 (PDT)
In-Reply-To: <449806B6.7060309@gmail.com>
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On 6/20/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 6/20/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> No it can't.  Once the card is in graphics mode, vgacon cannot go to
> >> text mode on its own.  It has to know how to write to other VGA
> >> registers which are unique per hardware.
> >
> > Might be a good place for a little call_usermodehelper example. VGAcon
> > could try calling vbetool to save it's state and restore it. GregKH
> > told me that the class firmware loader code was the place to start.
> >
>
> Yes, that's part of the plan. I'm still looking for the best inteface
> to do that. It must be a 2-way inteface, ie, kernel->user and user->kernel.
> Does the firmware loader code satisfy the above condition?

Currently the firmware loader  uses call_userhelper on a fixed helper
app. The code would need to be generalized so that you can call an
arbitrary app with your own parameters. Two communication while
running can be achieved via sysfs. Request firmware currently does two
way communication.

This thread should help.
http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=111129164916712&w=2

My thoughts are that it would be better to generalize the firmware
loader code that to build another version of it in the graphics code.

There are several later threads on the subject. Add me to the cc if
you start discussing this on hotplug-devel.

If I remember the discussions right request firmware is kind of broken
right now since it loads all of the firmware through a single place in
sysfs. Instead it should load the firmware by creating attributes on
the specific devices instead of having one attribute for everything.
Fixing it to allow parameters on the user space call is needed to tell
the user space script where to look for the device.

Request firmware is a very small amount of code and easy to modify.

-- 
Jon Smirl
jonsmirl@gmail.com
