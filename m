From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Wed, 07 Jun 2006 03:45:26 +0800
Message-ID: <4485DB56.7020004@gmail.com>
References: <44856223.9010606@gmail.com> <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751021AbWFFTpg@vger.kernel.org>
In-Reply-To: <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> On 6/6/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>> Overall, this feature is a great help for developers working in the
>> framebuffer or console layer.  There is not need to continually reboot
>> the
>> kernel for every small change. It is also useful for regular users who
>> wants
>> to choose between a graphical console or a text console without having to
>> reboot.
> 
> Instead of the sysfs attribute, what about creating a new escape
> sequence that you send to the console system to detach? Doing it that
> way would make more sense from a stacking order. It just seems
> backwards to me that you ask a lower layer to detach from the layer
> above it.

It is not the vt layer that attaches fbcon, it's fbcon that attaches
to the vt layer. So it is more logical that fbcon detaches itself, not
the other way around.
 
Tony
