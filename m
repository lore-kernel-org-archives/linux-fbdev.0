From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 15 Aug 2012 19:23:32 +0000
Subject: Re: [PATCHv2 0/8] *** ARM: Update arch-vt8500 to Devicetree ***
Message-Id: <502BF734.9000608@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344477300-25251-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1344477300-25251-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/08/2012 07:54 PM, Tony Prisk wrote:
> This patchset updates arch-vt8500 to devicetree and removes all the old-style
> code. Support for WM8650 has also been added.

Sorry for taking such a long time to re-review this.

I scanned the series looking for just the changes to the issues I raised
on v1, and I do see almost everything has been fixed up OK, except for
the one issue I just commented on. So, aside from that, this series is
fine by me. I'll defer to others about whether it's necessary to fix the
display node-name-vs.-phandle issue I pointed out, or defer that until
later.
