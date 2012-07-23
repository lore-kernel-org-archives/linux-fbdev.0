From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 23 Jul 2012 20:38:15 +0000
Subject: Re: [RFC][PATCH V2 3/3] tegra: add pwm backlight device tree nodes
Message-Id: <500DB637.8000502@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1341814105-20690-1-git-send-email-acourbot@nvidia.com> <1341814105-20690-4-git-send-email-acourbot@nvidia.com> <CAPnjgZ1QbjE+-tr0c01K2feUdEE2wMBfR=bKpTxnyDOJbY8+1Q@mail.gmail.com> <4FFEA2D4.9050308@nvidia.com> <CAPnjgZ2=Ga2P-40trA_=UABm=i7Uy4NTAM=ehea11mE22VfDew@mail.gmail.com> <4FFFB2DC.3040605@nvidia.com>
In-Reply-To: <4FFFB2DC.3040605@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot@nvidia.com>
Cc: Simon Glass <sjg@chromium.org>, Thierry Reding <thierry.reding@avionic-design.de>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>

On 07/12/2012 11:32 PM, Alex Courbot wrote:
> On 07/12/2012 11:27 PM, Simon Glass wrote
...
>>  From my understanding mixing strings and numbers in a property is
>> frowned on though.
> 
> But doesn't it make sense in the current case? The power sequence is
> basically a program that is run by an interpreter. From this
> perspective, it makes more sense to me to have it as a binary field
> rather than a hierarchy of nodes and properties that will be harder to
> parse and will make error detection more complicated. I don't really see
> any practical benefit from turning the steps into sub-nodes, but then
> again I am not so familiar with the DT.

Mixing strings and integers in a property isn't "allowed" (by convention
of DT bindings reviewers - as you noticed, dtc will happily compile it);
there are practical issues with attempting to do so, such as causing the
integer values to be unaligned, and thus causing the current integer
parsing code to fail, etc.
