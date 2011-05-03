From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 03 May 2011 05:42:39 +0000
Subject: Re: [PATCH v6 0/6] powerpc, 52xx: add charon board support
Message-Id: <BANLkTimacM29RHExZounuziF+7jARQxdTg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291451028-22532-1-git-send-email-hs@denx.de> <1300782452-528-1-git-send-email-hs@denx.de>
 <20110502221406.GA15043@ponder.secretlab.ca> <4DBF8FF6.8030100@denx.de>
In-Reply-To: <4DBF8FF6.8030100@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: hs@denx.de
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev@vger.kernel.org, devicetree-discuss@ozlabs.org, Ben Dooks <ben@simtec.co.uk>, Vincent Sanders <vince@simtec.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>, Wolfgang Denk <wd@denx.de>, Paul Mundt <lethal@linux-sh.org>

On Mon, May 2, 2011 at 11:17 PM, Heiko Schocher <hs@denx.de> wrote:
> Hello Grant,
>
> Grant Likely wrote:
>> On Tue, Mar 22, 2011 at 09:27:26AM +0100, Heiko Schocher wrote:
>>> cc: Wolfram Sang <w.sang@pengutronix.de>
>>> cc: Grant Likely <grant.likely@secretlab.ca>
>>> cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> cc: linux-fbdev@vger.kernel.org
>>> cc: devicetree-discuss@ozlabs.org
>>> cc: Ben Dooks <ben@simtec.co.uk>
>>> cc: Vincent Sanders <vince@simtec.co.uk>
>>> cc: Samuel Ortiz <sameo@linux.intel.com>
>>> cc: linux-kernel@vger.kernel.org
>>> cc: Randy Dunlap <rdunlap@xenotime.net>
>>> cc: Wolfgang Denk <wd@denx.de>
>>> cc: Paul Mundt <lethal@linux-sh.org>
>>>
>>> changes since v5:
>>> - repost complete patchseries, as Paul Mundt suggested
>>> - rebased against current head
>>> - add Acked-by from Samuel Ortiz (MFD parts)
>>> =A0 http://www.spinics.net/lists/linux-fbdev/msg02550.html
>>> =A0 http://linux.derkeiler.com/Mailing-Lists/Kernel/2011-01/msg11798.ht=
ml
>>>
>>> =A0 and Benjamin Herrenschmidt (DTS parts)
>>> =A0 http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-February/088279=
.html
>>> - removed patch
>>> =A0 "powerpc, mpc5200: update mpc5200_defconfig to fit for charon board=
."
>>> =A0 therefore added
>>> =A0 "powerpc, tqm5200: update tqm5200_defconfig to fit for charon board=
."
>>
>> Refresh my memory, why was the mpc5200_defconfig updated dropped?
>
> Because it is a board based on the tqm5200 board port ... no other
> reason.

Please send a patch to also update the mpc5200_defconfig.

g.
