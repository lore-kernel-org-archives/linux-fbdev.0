From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Thu, 31 Jan 2013 11:32:08 +0000
Subject: Re: [PATCH 1/3] video: exynos_mipi_dsi: Convert to devm_ioremap_resource()
Message-Id: <CAK9yfHwxhZ1MGEC_eswoNon9qN7n8_57z+2zrDYgU7nMTWSHuw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1359627939-2685-1-git-send-email-sachin.kamat@linaro.org>
	<20130131104241.GA8676@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20130131104241.GA8676@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, Donghwa Lee <dh09.lee@samsung.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

On 31 January 2013 16:12, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> On Thu, Jan 31, 2013 at 03:55:37PM +0530, Sachin Kamat wrote:
>> Use the newly introduced devm_ioremap_resource() instead of
>> devm_request_and_ioremap() which provides more consistent error handling.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Donghwa Lee <dh09.lee@samsung.com>
>> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
>> Cc: linux-fbdev@vger.kernel.org
>> ---
>>  drivers/video/exynos/exynos_mipi_dsi.c |    7 ++++---
>>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> All of these can drop the additional error message because equivalent
> error message are output by devm_ioremap_resource() itself.

Ah right.. I will remove them and re-send the patches.

-- 
With warm regards,
Sachin
