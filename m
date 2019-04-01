From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Apr 2019 15:13:08 +0000
Subject: Re: [PATCH 0/8] fbdev: sm712fb: fix a series of lockups, crashes and gliches.
Message-Id: <e381bda9-e681-5ded-1c2e-f045ad689674@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190316222504.27170-1-tomli@tomli.me>
        <CGME20190331121809epcas3p382bda421f972cd516bb7010700bc8a3d@epcas3p3.samsung.com>
        <20190331121801.ftwwm4dw2iev3xzf@debian>
In-Reply-To: <20190331121801.ftwwm4dw2iev3xzf@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org


On 03/31/2019 02:18 PM, Sudip Mukherjee wrote:
> On Sun, Mar 17, 2019 at 06:24:56AM +0800, Yifeng Li wrote:
>> Hi all,
>>
>> This patchset contains a series of important fixes to various problems,
>> including lockups, crashes, screen gliches, and missing video modes.
>> These patches are crucial to the correct operation to the hardware,
>> especially Lynx3DM+ (SM720). I have tested and verified them on x86.
>>
>> Please review and queue them for linux-stable.
> 
> Thanks for the changes.
> Verified the register changes from the datasheet and also tested the full
> series (separate test for individual patches) with SM712 on little endian
> for any regression.

Patches #1-8 queued for v5.2, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
