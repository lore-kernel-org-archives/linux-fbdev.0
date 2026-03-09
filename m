Received: from gz.d.sender-sib.com (gz.d.sender-sib.com [77.32.148.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496338BF83
	for <linux-fbdev@vger.kernel.org>; Mon,  9 Mar 2026 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051217; cv=none; b=qpkL9UrwMyz+g6SeFUhtuyA9OLifglj4jJR/huKRi07E2vciksER0/ZuY6WFUPy5qje7K8tWJzD7eqcs8O97Q7Qy3KKAQrbUS1JtyWnBzSb+OJ1GwyrhGXh+nY+IX8WuCKCiNjls/4q+HYwWlIXon002lvwfPY0zRwXpw/q3mVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051217; c=relaxed/simple;
	bh=leV9CnIFeoOPZI1o/0bHtXTdNX8/o6qWmLDRA8ywHug=;
	h=To:Date:Subject:From:Message-Id:Mime-Version:Cc; b=UcXF+5bPIktTo3n1/vxKKBoRAiNkp2c9KRfLbuxkELmp7yfT+NKL524QfMfA/dWA8X1lZIvqXnzmGJ+HyFRyIeE67A4My+dOHUzvSEwIvH1ixk42KuNRD/07xBQdB8/MBm4m4j9hJPQrFdTqSPpQtJ+Os+R9ISCs7Yj0Ce2ayFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dipeshchaudhary.in; spf=pass smtp.mailfrom=gz.d.sender-sib.com; dkim=pass (2048-bit key) header.d=dipeshchaudhary.in header.i=@dipeshchaudhary.in header.b=dQ38A2Gv; arc=none smtp.client-ip=77.32.148.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dipeshchaudhary.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gz.d.sender-sib.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dipeshchaudhary.in header.i=@dipeshchaudhary.in header.b="dQ38A2Gv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dipeshchaudhary.in;
 q=dns/txt; s=brevo1; bh=leV9CnIFeoOPZI1o/0bHtXTdNX8/o6qWmLDRA8ywHug=;
 h=from:subject:date:to:cc:mime-version:content-transfer-encoding:list-unsubscribe:x-csa-complaints:list-unsubscribe-post:message-id:x-sib-id:feedback-id;
        b=dQ38A2GvvhATBHyYIx263b0rywPYfKur/q1KcM5Zc+epDBEvcKY0yQ0sh9WHifa9pp9IZOhms4uQ
        8tTe57mV06Yw6K/SlFCWfnGD2stjB96D4wmag6C9fb/FkvqB4NfBSLZxiLwN/o7WGksT+myRPCSJ
        SebIJWUohDAqeYDYVYK6SPSJq6pZOz7NL17S+2NxRtGzCj803d5oUkt9KmvDZGRyvU328aSdofWC
        tAI0NW0MIU5QBkvXliQ5Strfof9OL39xOf9VzAdSHfGOZYt9oM+9G96QkpABXNv7urw7fnEoC7Cj
        /wnP/PkNr/ILrrDuL7HgfRn37m+7qihrqDjIPA==
To: <gregkh@linuxfoundation.org>
Date: Mon,  9 Mar 2026 10:13:11 +0000
Subject: Re: [PATCH] staging: sm750fb: constify g_fbmode array
Origin-messageId: <20260309101311.281366-1-me@dipeshchaudhary.in>
From: "dipesh chaudhary" <me@dipeshchaudhary.in>
X-sib-id: O6Gx71jixp-DkvHWxKEiAOipxwUBIwdDaimS45FeQGB3cTPR3JGF1LPmTBOiekJsaFtcpyGj1dKAYg_ndWmxilC3uf67RTnHOKuDzQsWsIZrFimS5QFksJe-AvWuzOW-m0-X3G5z9trgaOUJ0lFmxLokwPfZ-x3MoraQnL2cH6Is-Zf3BQGw4vU-
Message-Id: <635f086c-6aab-44fc-a8d3-7b19b77b178f@smtp-relay.sendinblue.com>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.26:10551297_-1:10551297:Sendinblue
X-CSA-Complaints: csa-complaints@eco.de
X-Mailin-EID: NDQ2MTgxMzU4fmxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZ348MjAyNjAzMDkxMDEzMTEuMjgxMzY2LTEtbWVAZGlwZXNoY2hhdWRoYXJ5LmluPn5nei5kLnNlbmRlci1zaWIuY29t
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.3
Content-Transfer-Encoding: quoted-printable
Cc: <sudipm.mukherjee@gmail.com>, <teddy.wang@siliconmotion.com>, <linux-fbdev@vger.kernel.org>, <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>


Hi Greg,

You were absolutely right. I just set up my local build environment and ran=
 `make drivers/staging/sm750fb/sm750.o`, and it immediately threw `error: a=
ssignment of read-only location`.

I fell into the classic checkpatch trap. I blindly applied the `const` sugg=
estion without checking the surrounding code, failing to realize the driver=
 dynamically writes to `g_fbmode` during runtime in `sm750fb_setup` and `ly=
nxfb_set_fbinfo`.=20

Thank you for pushing me to test-build. I will drop this patch entirely, as=
 the checkpatch warning is a false positive here. I have learned a valuable=
 lesson about not trusting static analysis scripts over actually reading th=
e C code and compiling it.

Best regards,
Dipesh Chaudhary


