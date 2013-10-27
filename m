From: Jingoo Han <jg1.han@samsung.com>
Date: Sun, 27 Oct 2013 23:08:15 +0000
Subject: Re: [PATCH 1/1] backlight: hx8357: Remove redundant of_match_ptr
Message-Id: <001a01ced369$6ad8c120$408a4360$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1382702373-19573-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382702373-19573-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sunday, October 27, 2013 11:22 PM, Maxime Ripard wrote:
> On Fri, Oct 25, 2013 at 05:29:33PM +0530, Sachin Kamat wrote:
> > 'hx8357_dt_ids' is always compiled in. Hence of_match_ptr is
> > not needed.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

