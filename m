From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 30 Oct 2013 03:24:12 +0000
Subject: Re: [PATCH 1/1] video: exynos_mipi_dsi: Remove unused variable
Message-Id: <CAK9yfHyBoHUs9v0eZ2yi2kmjr79ND6NSyeePfteUPNeG9Ub_UA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On 30 October 2013 04:30, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> On Fri, Oct 25, 2013 at 10:51:48AM +0530, Sachin Kamat wrote:
>> On 24 October 2013 21:25, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> > On Monday 21 October 2013 11:02 AM, Sachin Kamat wrote:
>> >> 'pdev' is not used anymore (Removed vide commit 7e0be9f9 "video:
>> >> exynos_mipi_dsim: Use the generic PHY driver"). Remove it and
>> >> silence the following compilation warning:
>> >> drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning:
>> >> unused variable =91pdev=92 [-Wunused-variable]
>> >>
>> >> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> > Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Thanks Kishon.
>>
>> I believe this patch should go through Greg's tree as your other
>> patches are lined up there?
>
> I don't take drivers/video/* patches now, am I?

Actually the patch that introduced this warning is lined up in your
usb-next tree [1]
as part of the phy series patches sent by Kishon. That is the reason I
thought this
one should go though your (usb) tree as well for now. Alternatively we
can wait for
rc-1 and then send it through the video tree if you prefer it that way.

[1] https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=
=3Dusb-next&id~0be9f9f7cba3356f75b86737dbe3a005da067e

--=20
With warm regards,
Sachin
