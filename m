From: David Herrmann <dh.herrmann@gmail.com>
Date: Wed, 13 Aug 2014 10:24:36 +0000
Subject: Re: [linux-sunxi] simplefb: add clock handling
Message-Id: <CANq1E4S3fv16_U-O16K2TPSMMiwZoXBzAWL3ektXz_tWnuYXaw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <CANq1E4Re79+D5H-pf8pW87NZ5MWz9UFknd5Dk2GKCvhzm5MNSA@mail.gmail.com>
 <BFCF4C2C-77ED-4719-903B-921DEB250B7A@dominion.thruhere.net>
 <53EB238B.5010404@redhat.com>
 <958E7D39-A034-42AC-A6FF-130609E46967@dominion.thruhere.net>
In-Reply-To: <958E7D39-A034-42AC-A6FF-130609E46967@dominion.thruhere.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi

On Wed, Aug 13, 2014 at 12:16 PM, Koen Kooi <koen@dominion.thruhere.net> wrote:
> So what you are saying is that the only reason it is needed is because some distros choose to build DRM drivers as modules. So as soon as they stop doing that the problem goes away, right?
> Worse, the experience I have with ARM DRM drivers is that they fail horrible when being built as modules, but that's a different problem.

Exactly. But there's no intention to stop building them as modules.
Imagine you build a kernel that's supposed to run on multiple
different platforms (like x86), you really don't want all DRM drivers
built-in. Instead, you load the correct driver during boot-up. To
still provide early graphics access, we use simplefb.

Note that there might be legitimate reasons to make DRM drivers
built-in. But at least general purpose distros avoid that.

Thanks
David
