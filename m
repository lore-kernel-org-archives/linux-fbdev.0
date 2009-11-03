From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] Add VirtIO Frame Buffer Support
Date: Tue, 03 Nov 2009 08:34:02 +0200
Message-ID: <4AEFCEDA.4030308@redhat.com>
References: <1257199759-2941-1-git-send-email-agraf@suse.de> <4AEFCBED.50804@redhat.com> <DB868FAB-60AA-4D3A-82AE-A3DAF1AF83B2@suse.de> <4AEFCCBA.9050408@redhat.com> <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <8BA1853F-11C9-44B1-9FDB-1DFDAED40E1B@suse.de>
Sender: kvm-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Alexander Graf <agraf@suse.de>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-fbdev-devel@lists.sourceforge.net, anthony@codemonkey.ws

On 11/03/2009 08:27 AM, Alexander Graf wrote:
>
>> How does it work today?
>
> You boot into a TERM=dumb line based emulation on 3270 (worst thing 
> haunting people's nightmares ever), trying to get out of that mode as 
> quickly as possible and off into SSH / VNC.

Despite the coolness factor, IMO a few minutes during install time do 
not justify a new hardware model and a new driver.

>> Does installation over vnc work?
>
> Yes, but it requires a working network setup. That's a pretty 
> requirement on guests IMHO.

Why?  the guest will typically have networking when it's set up, so it 
should have network access during install.  You can easily use slirp 
redirection and the built-in dhcp server to set this up with relatively 
few hassles.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

