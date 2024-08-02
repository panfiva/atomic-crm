import { Stack, Typography } from '@mui/material';
import { ReferenceField, TextField, useRecordContext } from 'react-admin';
import { Avatar } from '../contacts/Avatar';
import { Contact } from '../types';

const ContactOptionRender = () => {
    const record: Contact | undefined = useRecordContext();
    if (!record) return null;
    return (
        <Stack direction="row" gap={1} alignItems="center">
            <Avatar record={record} />
            <Stack>
                {record.first_name} {record.last_name}
                <Typography variant="caption" color="text.secondary">
                    {record.title} at{' '}
                    <ReferenceField
                        source="company_id"
                        reference="companies"
                        link={false}
                    >
                        <TextField source="name" variant="caption" />
                    </ReferenceField>
                </Typography>
            </Stack>
        </Stack>
    );
};
export const contactOptionText = <ContactOptionRender />;
export const contactInputText = (choice: {
    first_name: string;
    last_name: string;
}) => `${choice.first_name} ${choice.last_name}`;
