From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Thu, 14 Nov 2013 06:25:43 +0000
Subject: Re: [PATCH 1/1] video: exynos_mipi_dsi: Remove unused variable
Message-Id: <CAK9yfHx9k=kEnpuhwcw7ra-PDudvbB75HOpqAxbJoG2JLtsRNQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382333533-32740-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hi Tomi,

On 24 October 2013 21:25, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On Monday 21 October 2013 11:02 AM, Sachin Kamat wrote:
>> 'pdev' is not used anymore (Removed vide commit 7e0be9f9 "video:
>> exynos_mipi_dsim: Use the generic PHY driver"). Remove it and
>> silence the following compilation warning:
>> drivers/video/exynos/exynos_mipi_dsi.c:144:26: warning:
>> unused variable =91pdev=92 [-Wunused-variable]
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>

Now that phy patchset and your tree is already merged into Linus' tree,
please queue this patch in your tree.

--=20
With warm regards,
Sachin
