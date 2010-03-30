From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] added S6E63M0 AMOLED LCD Panel driver.
Date: Tue, 30 Mar 2010 16:02:57 -0700
Message-ID: <20100330160257.e5f978a9.akpm@linux-foundation.org>
References: <90b950fc1003252024i5ba8989bg95f0a81e8e5e708e@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <90b950fc1003252024i5ba8989bg95f0a81e8e5e708e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: InKi Dae <daeinki@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com

On Fri, 26 Mar 2010 12:24:24 +0900
InKi Dae <daeinki@gmail.com> wrote:

> +static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
> +{
> +	int ret;
> +
> +	ret = s6e63m0_panel_send_sequence(lcd, SEQ_PANEL_CONDITION_SET);
> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_DISPLAY_CONDITION_SET);
> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_GAMMA_SETTING);
> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_ETC_CONDITION_SET);
> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_ACL_ON);
> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_ELVSS_ON);
> +
> +	return ret;
> +}

Well.  If one call to s6e63m0_panel_send_sequence() returns -ENOMEM and
another call returns -EIO (for example), this function will return some
other, incorrect errno.

Which is a rather minor problem, unless some caller is explicitly
looking for some particular error code, which doesn't happen often.
