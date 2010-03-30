From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [Linux-fbdev-devel] [PATCH] added S6E63M0 AMOLED LCD Panel
	driver.
Date: Tue, 30 Mar 2010 18:24:51 -0500
Message-ID: <0D753D10438DA54287A00B027084269763691C3440@AUSP01VMBX24.collaborationhost.net>
References: <90b950fc1003252024i5ba8989bg95f0a81e8e5e708e@mail.gmail.com>
 <20100330160257.e5f978a9.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100330160257.e5f978a9.akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
To: Andrew Morton <akpm@linux-foundation.org>, InKi Dae <daeinki@gmail.com>
Cc: "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Tuesday, March 30, 2010 4:03 PM, Andrew Morton wrote:
> On Fri, 26 Mar 2010 12:24:24 +0900
> InKi Dae <daeinki@gmail.com> wrote:
> 
>> +static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
>> +{
>> +	int ret;
>> +
>> +	ret = s6e63m0_panel_send_sequence(lcd, SEQ_PANEL_CONDITION_SET);
>> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_DISPLAY_CONDITION_SET);
>> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_GAMMA_SETTING);
>> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_ETC_CONDITION_SET);
>> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_ACL_ON);
>> +	ret |= s6e63m0_panel_send_sequence(lcd, SEQ_ELVSS_ON);
>> +
>> +	return ret;
>> +}
>
> Well.  If one call to s6e63m0_panel_send_sequence() returns -ENOMEM and
> another call returns -EIO (for example), this function will return some
> other, incorrect errno.
>
> Which is a rather minor problem, unless some caller is explicitly
> looking for some particular error code, which doesn't happen often.

Why not handle the calls with a loop?

+static int s6e63m0_ldi_init(struct s6e63m0 *lcd)
+{
+	const unsigned short *init_seq[] = {
+		SEQ_PANEL_CONDITION_SET,
+		SEQ_DISPLAY_CONDITION_SET,
+		SEQ_GAMMA_SETTING,
+		SEQ_ETC_CONDITION_SET,
+		SEQ_ACL_ON,
+		SEQ_ELVSS_ON,
+	};
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(init_seq); i++) {
+		ret = s6e63m0_panel_send_sequence(lcd, init_seq[i]);
+		if (ret)
+			break;
+	}
+	return ret;
+}

Note that _s6e63m0_gamma_ctl has the same issue.  Actually, the whole
driver has issues with returning errors properly.

Regards,
Hartley