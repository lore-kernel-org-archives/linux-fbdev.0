Received: from a7-47.smtp-out.eu-west-1.amazonses.com (a7-47.smtp-out.eu-west-1.amazonses.com [54.240.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2229C154423
	for <linux-fbdev@vger.kernel.org>; Mon, 16 Sep 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487044; cv=none; b=mfj/cJeBQ/dvyjrbTFfExp09W28HWkQ6lAHYgnEX33xmm0EzSMl8uz2/mYpjgE32IzpCNqBkeoZRlHf3pq5quMGXlabo+XwG8dHK18VWlMtWXWUInKAgxeB7/h3nUFtvuurYcpL1OaYvGB6+KYC/ButyIbqQjNE71uD+qgfXbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487044; c=relaxed/simple;
	bh=b5L+BBRFjwrBqM3ff8bwbIGSDSf9+53bhi6MdbUX+Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iuGUc4s0oZg/yJJM/b8sZNOAFbyaijvCl+D+tHPplKr+DV3yiZ3PCPySEhtrbbSn2EAZDbPvv0jxbc24WMArEPIoYj6hhGOELxI1nWcC6AeA6M8eQ4QAPp0F74fk91UzOAB7mt5y38yOxhCeDaIObwDQk2GTjQVqnhvYpjkkdA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z0kfdFE9; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=VmZD2pbF; arc=none smtp.client-ip=54.240.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z0kfdFE9";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="VmZD2pbF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726487041;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=b5L+BBRFjwrBqM3ff8bwbIGSDSf9+53bhi6MdbUX+Y8=;
	b=Z0kfdFE9zunJ1rBJ0PmpTkwqmNU5sgxzDbI1A/gbARdF/rsM9E32bJekvej7uVYu
	eZi/DwT4OO9IdZGPu6+5k+3I8ECCnnNvnV5BjVaGb3UeGYJO3Ij/ShrzyIITx7U7I43
	niXLwpu9ffeTdlNgR/BV3wSriyj65u4HpokODuE02AU4YCMGERAcml33xCnuNLW/g7d
	1OaNoENn5yQKnfhhgSGZAOhxOLeKOKUl4Ug8Y0AUpI3b+j4LQLKDWH60h8ZZcB3cW4D
	F1AJ9HMiSglhvDNK0zkpPkPb85IhbM91HFjN5dg73/7qeczYueOW57U3dDsz20TDV0i
	iKkXOGB55Q==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726487041;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=b5L+BBRFjwrBqM3ff8bwbIGSDSf9+53bhi6MdbUX+Y8=;
	b=VmZD2pbFvv59GjJHMj3BAvfeIz4oDq4W5W3arWQEBF1vObNW+KbCxfU0NQ+pJsj2
	poUC5tGfWTdsVVACHJF5lq3lVAPOsZZJrBsH+N41lHUJupcUNQ2ZgHwp/78yK99jIVA
	fKHdpkZljoTWj3lQTc+GeJdss5BEmpCbYYaFMGmU=
Message-ID: <01020191faa595af-dba2cbbd-d487-4837-a923-7844fae7c1de-000000@eu-west-1.amazonses.com>
Date: Mon, 16 Sep 2024 11:44:01 +0000
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/connector: hdmi: Fix writing Dynamic Range
 Mastering infoframes
To: Jani Nikula <jani.nikula@linux.intel.com>, 
	dri-devel@lists.freedesktop.org
Cc: Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
	Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
References: <20240827163918.48160-1-derek.foreman@collabora.com>
 <87cyltyros.fsf@intel.com>
Content-Language: en-US
From: Derek Foreman <derek.foreman@collabora.com>
In-Reply-To: <87cyltyros.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.16-54.240.7.47

Gentle ping - is there anything more I need to do before this can land?

Thanks,
Derek

On 2024-08-28 03:31, Jani Nikula wrote:
> On Tue, 27 Aug 2024, Derek Foreman <derek.foreman@collabora.com> wrote:
>> The largest infoframe we create is the DRM (Dynamic Range Mastering)
>> infoframe which is 26 bytes + a 4 byte header, for a total of 30
>> bytes.
>>
>> With HDMI_MAX_INFOFRAME_SIZE set to 29 bytes, as it is now, we
>> allocate too little space to pack a DRM infoframe in
>> write_device_infoframe(), leading to an ENOSPC return from
>> hdmi_infoframe_pack(), and never calling the connector's
>> write_infoframe() vfunc.
>>
>> Instead of having HDMI_MAX_INFOFRAME_SIZE defined in two places,
>> replace HDMI_MAX_INFOFRAME_SIZE with HDMI_INFOFRAME_SIZE(MAX) and make
>> MAX 27 bytes - which is defined by the HDMI specification to be the
>> largest infoframe payload.
>>
>> Fixes: f378b77227bc ("drm/connector: hdmi: Add Infoframes generation")
>> Fixes: c602e4959a0c ("drm/connector: hdmi: Create Infoframe DebugFS entries")
>>
> Superfluous blank line. Can be fixed while applying.
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
>
>> Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
>> ---
>>   drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 +---
>>   drivers/gpu/drm/drm_debugfs.c                   | 4 +---
>>   include/linux/hdmi.h                            | 9 +++++++++
>>   3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> index 7854820089ec..feb7a3a75981 100644
>> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
>> @@ -521,8 +521,6 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
>>   }
>>   EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
>>   
>> -#define HDMI_MAX_INFOFRAME_SIZE		29
>> -
>>   static int clear_device_infoframe(struct drm_connector *connector,
>>   				  enum hdmi_infoframe_type type)
>>   {
>> @@ -563,7 +561,7 @@ static int write_device_infoframe(struct drm_connector *connector,
>>   {
>>   	const struct drm_connector_hdmi_funcs *funcs = connector->hdmi.funcs;
>>   	struct drm_device *dev = connector->dev;
>> -	u8 buffer[HDMI_MAX_INFOFRAME_SIZE];
>> +	u8 buffer[HDMI_INFOFRAME_SIZE(MAX)];
>>   	int ret;
>>   	int len;
>>   
>> diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
>> index 6b239a24f1df..9d3e6dd68810 100644
>> --- a/drivers/gpu/drm/drm_debugfs.c
>> +++ b/drivers/gpu/drm/drm_debugfs.c
>> @@ -520,8 +520,6 @@ static const struct file_operations drm_connector_fops = {
>>   	.write = connector_write
>>   };
>>   
>> -#define HDMI_MAX_INFOFRAME_SIZE		29
>> -
>>   static ssize_t
>>   audio_infoframe_read(struct file *filp, char __user *ubuf, size_t count, loff_t *ppos)
>>   {
>> @@ -579,7 +577,7 @@ static ssize_t _f##_read_infoframe(struct file *filp, \
>>   	struct drm_connector *connector; \
>>   	union hdmi_infoframe *frame; \
>>   	struct drm_device *dev; \
>> -	u8 buf[HDMI_MAX_INFOFRAME_SIZE]; \
>> +	u8 buf[HDMI_INFOFRAME_SIZE(MAX)]; \
>>   	ssize_t len = 0; \
>>   	\
>>   	connector = filp->private_data; \
>> diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
>> index 3bb87bf6bc65..455f855bc084 100644
>> --- a/include/linux/hdmi.h
>> +++ b/include/linux/hdmi.h
>> @@ -59,6 +59,15 @@ enum hdmi_infoframe_type {
>>   #define HDMI_DRM_INFOFRAME_SIZE    26
>>   #define HDMI_VENDOR_INFOFRAME_SIZE  4
>>   
>> +/*
>> + * HDMI 1.3a table 5-14 states that the largest InfoFrame_length is 27,
>> + * not including the packet header or checksum byte. We include the
>> + * checksum byte in HDMI_INFOFRAME_HEADER_SIZE, so this should allow
>> + * HDMI_INFOFRAME_SIZE(MAX) to be the largest buffer we could ever need
>> + * for any HDMI infoframe.
>> + */
>> +#define HDMI_MAX_INFOFRAME_SIZE    27
>> +
>>   #define HDMI_INFOFRAME_SIZE(type)	\
>>   	(HDMI_INFOFRAME_HEADER_SIZE + HDMI_ ## type ## _INFOFRAME_SIZE)
